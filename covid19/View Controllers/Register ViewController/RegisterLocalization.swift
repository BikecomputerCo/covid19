import Foundation


extension RegisterViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        titleLabel.text         = "Register".localized()
        descriptionLabel.text   = "By filling out the daily report for your symptoms, you help us to identify the risk categories of patients faster and more efficiently and to act accordingly in terms of their isolation and treatment.".localized()
        emailTitle.text         = "Enter email".localized() + " *"
        passwordTitle.text      = "Password".localized() + " *"
        phoneNumberTitle.text   = "Enter your phone number".localized()
        
        emailField.setPlaceholder(placeholder: "email".localized())
        passwordField.setPlaceholder(placeholder: "password".localized())
        registerButton.setTitle("Register".localized(), for: .normal)
    }
    
    // MARK: -
}
