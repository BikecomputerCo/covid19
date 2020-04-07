import Foundation
import Firebase
import Localize_Swift

enum Localization: String {
    case macedonian = "mk-MK"
    case albanian   = "sq-MK"
    case english    = "en"
    
    var title: String {
        switch self {
        case .macedonian:
            return "Macedonian".localized()
        case .albanian:
            return "Albanian".localized()
        case .english:
            return "English".localized()
        }
    }
}

struct LocalizationManager {
    static func changeLocalizationTo(localization: Localization) {
        Localize.setCurrentLanguage(localization.rawValue)
        Auth.auth().languageCode = localization.rawValue
    }
    
    static func currentLocalization() -> Localization {
        let code = Localize.currentLanguage()
        return Localization(rawValue: code) ?? .macedonian
    }
}
