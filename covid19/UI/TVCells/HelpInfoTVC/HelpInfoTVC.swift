import UIKit

class HelpInfoTVC: UITableViewCell, Reusable, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet private var titleLabel:       UILabel!
    @IBOutlet private var phoneLabel:       UILabel!
      
    // MARK: -
    // MARK: - Variables
      
    // Public
    var helpInfo: HelpInfo? {
        didSet {
            displayData()
        }
    }
            
    // MARK: -
    // MARK: - Data
      
    private func displayData() {
        guard let validHelpInfo = helpInfo else { return }
        titleLabel.text = validHelpInfo.location.value
        phoneLabel.text = validHelpInfo.phoneNumber
    }
      
    // MARK: -
}
