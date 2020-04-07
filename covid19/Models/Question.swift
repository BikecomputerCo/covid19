import Foundation
import Firebase

struct Question {
    let title:          Translation
    let description:    Translation
    let answers:        [AnswerOption]
    
    init(document: DocumentSnapshot) {
        title           = Translation(document: document[Keys.title.rawValue] as? [String: Any])
        description     = Translation(document: document[Keys.description.rawValue] as? [String: Any])
        
        if let documents = document[Keys.answers.rawValue] as? [[String: Any]] {
            answers = documents.compactMap({ AnswerOption(document: $0) })
        } else {
            answers = []
        }
    }
    
    enum Keys: String {
        case title, description, answers
    }
}

struct AnswerOption {
    let title:      Translation
    let colored:    Bool
    
    init?(document: [String: Any]?) {
        if document == nil {
            return nil
        } else {
            title   = Translation(document: document?[Keys.title.rawValue] as? [String: Any])
            colored = document?[Keys.colored.rawValue] as? Bool ?? false
        }
    }
    
    enum Keys: String {
        case title
        case colored
    }
}

