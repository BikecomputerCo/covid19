import Foundation
import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == languageField {
            showChangeLocalizationSheet()
            return false
        }
        
        return true
    }
}
