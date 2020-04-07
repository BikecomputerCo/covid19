import Foundation
import UIKit

extension PhoneVerificationViewController {
    func configure() {
        confNavigationBar()
        confButtons()
    }
    
    private func confNavigationBar() {
        navigationItem.leftBarButtonItem = nil
    }
    
    private func confButtons() {
        let cornerRadius: CGFloat           = 25.0
        confirmButton.layer.cornerRadius    = cornerRadius
        cancelButton.layer.cornerRadius     = cornerRadius
    }
}
