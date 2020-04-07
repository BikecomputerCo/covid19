import Foundation
import Firebase

struct HelpInfo {
    let phoneNumber:    String
    let location:       Translation
    
    init(document: DocumentSnapshot) {
        phoneNumber = document[Keys.phoneNumber.rawValue] as? String ?? ""
        location    = Translation(document: document[Keys.location.rawValue] as? [String: Any])
    }
    
    enum Keys: String {
        case phoneNumber = "phone_number"
        case location
    }
}
