import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            if loginType == .email {
                passwordField.becomeFirstResponder()
            } else {
                loginButtonAction(sender: loginButton)
            }
            
        } else if textField == passwordField {
            loginButtonAction(sender: loginButton)
        }
        
        return true
    }
}
