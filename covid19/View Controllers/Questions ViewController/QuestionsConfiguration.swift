import Foundation
import UIKit

extension QuestionsViewController {
    func configure() {
        confButtons()
    }
    
    private func confButtons() {
        let cornerRadius: CGFloat               = 25.0
        let borderSize: CGFloat                 = 1.0
        
        
        var tag = 1
        while let button = view.viewWithTag(tag) as? UIButton {
            button.layer.cornerRadius      = cornerRadius
            button.layer.borderColor       = UIColor.App.black10.cgColor
            button.layer.borderWidth       = borderSize
            
            tag += 1
        }
    }
    
    func makeButtonOrange(button: UIButton) {
        button.backgroundColor = UIColor.App.orange
        button.setTitleColor(.white, for: .normal)
    }
    
    func makeButtonWhite(button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(UIColor.App.black100, for: .normal)
    }
}
