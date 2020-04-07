import Foundation
import UIKit

extension UITextField {
    func setPlaceholder(placeholder: String) {
        let placeholderAttributes = [NSAttributedString.Key.font: self.font, NSAttributedString.Key.foregroundColor: self.textColor]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes as [NSAttributedString.Key : Any])
    }
}
