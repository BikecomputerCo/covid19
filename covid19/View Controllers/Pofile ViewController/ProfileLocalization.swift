import Foundation
import Localize_Swift

extension ProfileViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        title = "Profile".localized()
        
        emailLabel.text = "Email".localized()
        phoneLabel.text = "Phone number".localized()
        languageLabel.text = "Language".localized()
        
        logoutButton.setTitle("Logout".localized(), for: .normal)
        deleteButton.setTitle("Delete account".localized(), for: .normal)
        
        languageField.text = LocalizationManager.currentLocalization().title
    }
    
    // MARK: - Actions

    func showChangeLocalizationSheet() {
        var localizations: [Localization] = []
        for code in Localize.availableLanguages() {
            if let localization = Localization(rawValue: code) {
                localizations.append(localization)
            }
        }
        
        let alertController = UIAlertController(title: "Language change".localized(), message: "Choose the language in which you want to see the application".localized(), preferredStyle: .actionSheet)
        for localization in localizations {
            let action = UIAlertAction(title: localization.title, style: .default) { (_) in
                LocalizationManager.changeLocalizationTo(localization: localization)
            }
            
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Dismiss".localized(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: -

    
    // MARK: -
}
