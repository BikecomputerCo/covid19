import Foundation

struct Translation {
    let en: String
    let mk: String
    let al: String
    
    init(document: [String: Any]?) {
        en     = document?[Keys.en.rawValue] as? String ?? ""
        mk     = document?[Keys.mk.rawValue] as? String ?? ""
        al     = document?[Keys.al.rawValue] as? String ?? ""
    }
    
    enum Keys: String {
        case en, al, mk
    }
    
    var value: String {
        let localization = LocalizationManager.currentLocalization()
        switch localization {
        case .macedonian:
            return mk
        case .albanian:
            return al
        case .english:
            return en
        }
    }
}
