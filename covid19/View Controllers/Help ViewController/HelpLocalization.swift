import Foundation

extension HelpViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        title = "Help Numbers".localized()
        titleLabel.text = "If you have COVID-19 symptoms call the closest health center according to your living location".localized()
    
        dataTableView.reloadData()
    }
    
    // MARK: -
}
