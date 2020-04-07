import Foundation
import Firebase
import FirebaseFirestore

class ConnectionsManager {
    static let shared = ConnectionsManager()
    
    var messageManager: GNSMessageManager!
    var permission:     GNSPermission?
    var publication:    GNSPublication?
    var subscription:   GNSSubscription?
    var users: Set<User> = []
    var saveTimer: Timer?
    
    let connectedTime = 30
    
    init() {
        messageManager = GNSMessageManager(apiKey: .googleNearbyAPIKey, paramsBlock: { (params: GNSMessageManagerParams?) in
          guard let params = params else { return }
          params.bluetoothPowerErrorHandler = { (hasError: Bool) in
            if hasError {
                // Display Alert
            }
          }
          params.bluetoothPermissionErrorHandler = { (hasError: Bool) in
            if hasError {
                // Display Alert
            }
          }
        })
        
        startSaveTimer()
    }
    
    func startNetwork() {
        permission = GNSPermission(changedHandler: { (granted: Bool) in
            if granted {
//                self.startPublishing()
//                self.startListening()
            }
        })
        
        self.startPublishing()
        self.startListening()
    }
    
    func startPublishing() {
        let id: String = Auth.auth().currentUser?.uid ?? ""
        let message = GNSMessage(content: id.data(using: .utf8))
        
        publication = messageManager.publication(with: message, paramsBlock: { (params) in
            guard let params = params else { return }
            
            params.strategy = GNSStrategy(paramsBlock: { (params: GNSStrategyParams?) in
                guard let params = params else { return }
                params.discoveryMediums     = .BLE
                params.discoveryMode        = .default
                params.allowInBackground    = true
            })
            
            params.permissionRequestHandler = { (permissionHandler: GNSPermissionHandler?) in
                permissionHandler?(true)
            }
        })
    }
    
    func startListening() {
        subscription = messageManager.subscription(messageFoundHandler: { (message: GNSMessage?) in
           /* Adding user */
            
            guard let message = message else { return }
            guard let identifier = String(data: message.content, encoding: .utf8) else { return }
            
            let user = User(userID: identifier, date: Timestamp(date: Date()))
            if !self.users.contains(user) {
                self.users.insert(user)
                
                if self.users.count > 450 {
                    self.saveTimer?.invalidate()
                    self.saveData()
                }
            }
        },
        messageLostHandler: { (message: GNSMessage?) in
            /* Removing user */
            guard let message = message else { return }
            guard let identifier = String(data: message.content, encoding: .utf8) else { return }
            
            let user = User(userID: identifier, date: Timestamp(date: Date()))
            if let oldUser = self.users.first(where: { $0.hashValue == user.hashValue }) {
                let seconds = Calendar.current.compare(oldUser.date.dateValue(), to: user.date.dateValue(), toGranularity: .second).rawValue
                if seconds < self.connectedTime {
                    self.users.remove(oldUser)
                }
            }
        },
        paramsBlock:{ (params: GNSSubscriptionParams?) in
            guard let params = params else { return }
            params.strategy = GNSStrategy(paramsBlock: { (params: GNSStrategyParams?) in
                guard let params = params else { return }
                params.allowInBackground = true
                params.discoveryMediums = .BLE
            })
        })
    }
    
    private func startSaveTimer() {
        saveTimer = Timer.scheduledTimer(timeInterval: 60.0 * 5.0, target: self, selector: #selector(saveData), userInfo: nil, repeats: false)
    }

    @objc func saveData() {
        var filteredUsers = users.filter {
            let seconds = Calendar.current.compare($0.date.dateValue(), to: Date(), toGranularity: .second).rawValue
            return seconds >= self.connectedTime
        }
        
        var usersToSave: [User] = []
        while usersToSave.count > 450, filteredUsers.count == 0 {
            if let user = filteredUsers.popFirst() {
                usersToSave.append(user)
                users.remove(user)
            }
        }
        
        
        if let myUser = Auth.auth().currentUser {
            let db      = Firestore.firestore()
            let batch   = db.batch()
            
            for user in usersToSave {
                let documentRef = db.collection("users").document(myUser.uid).collection("connections").document(user.userID)
                batch.setData(["userID": user.userID, "date": user.date], forDocument: documentRef)
            }
            
            batch.commit() { error in
                if let error = error {
                    // Handle errors
                    print("Error writing batch \(error)")
                    
                    self.startSaveTimer()
                } else {
                    self.startSaveTimer()
                }
            }
        }
    }
}
