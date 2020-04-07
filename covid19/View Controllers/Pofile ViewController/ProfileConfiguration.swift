import Foundation
import UIKit

extension ProfileViewController {
    func configure() {
        confButtons()
    }
    
    private func confButtons() {
        let cornerRadius: CGFloat       = 25.0
        logoutButton.layer.cornerRadius = cornerRadius
    }
}
