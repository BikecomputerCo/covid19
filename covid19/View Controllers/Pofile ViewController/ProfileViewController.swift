import UIKit
import Firebase
import Localize_Swift

class ProfileViewController: UIViewController {
    // MARK: - Outlets
        
    // Labels
    @IBOutlet var emailLabel:       UILabel!
    @IBOutlet var phoneLabel:       UILabel!
    @IBOutlet var languageLabel:    UILabel!
    
    // Fields
    @IBOutlet var emailField:       UITextField!
    @IBOutlet var phoneField:       UITextField!
    @IBOutlet var languageField:    UITextField!
    
    // Buttons
    @IBOutlet var logoutButton:     LoadingButton!
    @IBOutlet var deleteButton:     LoadingButton!
    
    // MARK: -
    // MARK: - Variables

    
    // MARK: -
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure */
        configure()
        
        /* Localization */
        updateTextForNewLocalization()
        
        /* Data */
        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Add Observers */
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextForNewLocalization), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Remove Observers */
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -
    // MARK: - Data
    
    private func setData() {
        if let user = Auth.auth().currentUser {
            emailField.text = user.email
            if let phone = user.phoneNumber, phone.count > 4 {
                phoneField.text = phone
            } else {
                phoneField.text = "No telephone number".localized()
            }
        }
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func logoutButtonAction(sender: UIButton) {
        showConfirmationAlert(title: nil, message: "Are you sure you want to logout?".localized(), confirmActionName: "Yes".localized(), cancelActionName: "Dismiss".localized()) { (result) in
            if result {
                self.logoutUser()
            }
        }
    }
    
    @IBAction func deleteButtonAction(sender: UIButton) {
        showConfirmationAlert(title: "Are you sure you want to delete you user?".localized(), message: "All data will be deleted".localized(), confirmActionName: "Yes, delete my account".localized(), cancelActionName: "Dismiss".localized()) { (result) in
            if result {
                self.deleteUser()
            }
        }
    }
    
    // MARK: -
    // MARK: - Networking
    
    private func logoutUser() {
        logoutButton.startLoadingAnimation()
        deleteButton.isUserInteractionEnabled = false
        
        do {
            try Auth.auth().signOut()
            self.signInAnonymously()
        } catch (let error) {
            self.reset()
            self.showAlert(message: error.localizedDescription)
        }
    }
    
    private func signInAnonymously() {
        Auth.auth().signInAnonymously { (result, error) in
            ConnectionsManager.shared.startPublishing()
            self.close()
        }
    }
    
    private func deleteUser() {
        logoutButton.isUserInteractionEnabled = false
        deleteButton.startLoadingAnimation()
        
        
        Auth.auth().currentUser?.delete(completion: { (error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.reset()
                return
            }
            
           self.signInAnonymously()
        })
    }
    
    // MARK: -
    // MARK: - Navigation
       
    private func close() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: -
    // MARK: - Other
    
    private func reset() {
        DispatchQueue.main.async {
            self.deleteButton.isUserInteractionEnabled = true
            self.logoutButton.isUserInteractionEnabled = true
            self.logoutButton.setTitle("Logout".localized(), for: .normal)
            self.deleteButton.setTitle("Delete account".localized(), for: .normal)
        }
    }
    
    // MARK: -
}
