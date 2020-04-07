import Foundation
import Firebase

struct AboutCovid {
    private let about: Translation
    
    init(document: DocumentSnapshot) {
        about = Translation(document: document[Keys.about.rawValue] as? [String: Any])
    }
    
    enum Keys: String {
        case about
    }
    
    var text: String {
        return about.value.replacingOccurrences(of: "\\n", with: "\n")
    }
}
