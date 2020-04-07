import Foundation
import Firebase
import Localize_Swift

struct CityBaseInfo {
    let city        : Translation
    let sick        : Int
    let cured       : Int
    let death       : Int
    let active      : Int
    let total       : Int
    
    init(document: DocumentSnapshot) {
        city        = Translation(document: document[Keys.city.rawValue] as? [String: Any])
        
        sick        = document[Keys.sick.rawValue]      as? Int ?? 0
        cured       = document[Keys.cured.rawValue]     as? Int ?? 0
        death       = document[Keys.death.rawValue]     as? Int ?? 0
        active      = document[Keys.active.rawValue]    as? Int ?? 0
        total       =  sick + cured + active + death
    }
    
    enum Keys: String {
        case city
        case sick
        case cured
        case death
        case active
    }
}
