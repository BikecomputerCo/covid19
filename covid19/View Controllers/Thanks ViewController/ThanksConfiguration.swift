import Foundation
import UIKit

extension ThanksViewController {
    func configure() {
        confButtons()
    }
    
    private func confButtons() {
        let cornerRadius: CGFloat       = 25.0
        backButton.layer.cornerRadius   = cornerRadius
    }
}
