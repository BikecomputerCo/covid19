import Foundation

extension InfoViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        titleLabel.text = "What is COVID-19?".localized()
        textView.text = aboutCovid?.text
        backButton.setTitle("Back".localized(), for: .normal)
    }
    
    // MARK: -
}
