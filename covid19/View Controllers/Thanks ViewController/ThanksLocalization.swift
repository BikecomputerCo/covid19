import Foundation

extension ThanksViewController {
    // MARK: - Functions

    @objc func updateTextForNewLocalization() {
        titleLabel.text         = "Thank you for your report and contribution to dealing with KOVID-19.".localized()
        descriptionLabel.text   = "We look forward to hearing from you and during tomorrow.".localized()
        backButton.setTitle("Back to main screen".localized(), for: .normal)
    }
    
    // MARK: -
}
