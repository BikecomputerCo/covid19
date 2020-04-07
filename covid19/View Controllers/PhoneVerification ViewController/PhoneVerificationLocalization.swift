import Foundation

extension PhoneVerificationViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        title = "Enter verification code".localized()
        
        titleLabel.text         = "Please enter the code that was sent to your mobile phone".localized() + "\n" + phoneNumber
        noCodeLabel.text        = "Didn't receive the SMS code?".localized()
        codeField.placeholder   = "456...".localized()
        confirmButton.setTitle("Confirm".localized(), for: .normal)
        resendCodeButton.setTitle("Send again".localized(), for: .normal)
        cancelButton.setTitle("Cancel".localized(), for: .normal)
    }
    
    // MARK: -
}
