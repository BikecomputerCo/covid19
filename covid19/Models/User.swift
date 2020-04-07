import Foundation
import Firebase

struct User: Equatable, Hashable {
    let userID: String
    let date: Timestamp
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.userID == rhs.userID
    }
}
