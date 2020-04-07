import Foundation
import Firebase

struct CountryBaseInfo {
    let date        : Date
    let sick        : Int
    let cured       : Int
    let death       : Int
    let active      : Int
    let total       : Int
    
    init(document: DocumentSnapshot) {
        if let interval = document[Keys.date.rawValue] as? Timestamp {
            date = interval.dateValue()
        } else {
            date = Date()
        }
        
        sick    = document[Keys.sick.rawValue]      as? Int ?? 0
        cured   = document[Keys.cured.rawValue]     as? Int ?? 0
        death   = document[Keys.death.rawValue]     as? Int ?? 0
        active  = document[Keys.active.rawValue]    as? Int ?? 0
        total   =  sick + cured + active + death
    }
    
    enum Keys: String {
        case date
        
        case cured
        case death
        case sick
        case active
    }
}
