import Foundation
import UIKit

extension HelpViewController {
    func configure() {
        confTableViews()
    }
    
    private func confTableViews() {
        /* Cell Registration */
        dataTableView.register(HelpInfoTVC.self)
    }
}
