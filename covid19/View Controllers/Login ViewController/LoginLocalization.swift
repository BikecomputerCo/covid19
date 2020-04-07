import Foundation

extension LoginViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        title = "User Login".localized()
        emailButton.setTitle("Email".localized(), for: .normal)
        phoneButton.setTitle("Phone number".localized(), for: .normal)
        loginButton.setTitle("Login".localized(), for: .normal)
        
        usernameLabel.text = "Enter email".localized()
        passwordLabel.text = "Password".localized()
        usernameField.setPlaceholder(placeholder: "Email".localized())
        passwordField.setPlaceholder(placeholder: "Password".localized())
    }
    
    // MARK: -
}
