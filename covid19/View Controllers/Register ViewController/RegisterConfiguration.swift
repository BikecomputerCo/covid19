import Foundation

extension RegisterViewController {
    func configure() {
        confButtons()
        confTextFields()
    }
    
    private func confButtons() {
        registerButton.layer.cornerRadius = 25.0
        backButton.layer.cornerRadius = 25.0
    }
    
    private func confTextFields() {
        phoneNumberField.withFlag               = true
        phoneNumberField.withPrefix             = true
        phoneNumberField.withExamplePlaceholder = true
    }
}
