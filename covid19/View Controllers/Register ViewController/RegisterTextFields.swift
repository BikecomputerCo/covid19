import UIKit

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            phoneNumberField.becomeFirstResponder()
        } else if textField == phoneNumberField {
            starUserRegistration()
        }
        
        return true
    }
}
