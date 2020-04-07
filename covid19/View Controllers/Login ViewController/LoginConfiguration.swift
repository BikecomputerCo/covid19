import Foundation
import UIKit

extension LoginViewController {
    func configure() {
        confViews()
        confButtons()
        confTextFields()
    }
    
    private func confViews() {
        let cornerRadius: CGFloat       = 12.0
        usernameView.layer.cornerRadius = cornerRadius
        passwordView.layer.cornerRadius = cornerRadius
    }
    
    private func confButtons() {
        loginButton.layer.cornerRadius  = 25.0
    }
    
    private func confTextFields() {
        usernameField.setPlaceholder(placeholder: "Email".localized())
        passwordField.setPlaceholder(placeholder: "Password".localized())
        
        phoneNumberField.withFlag               = true
        phoneNumberField.withPrefix             = true
        phoneNumberField.withExamplePlaceholder = true
    }
}
