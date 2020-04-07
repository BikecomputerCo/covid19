import Foundation
import UIKit
import Firebase

extension StartViewController {
    func configure() {
        confButtons()
        confTableViews()
    }
    
    private func confButtons() {
        let cornerRadius: CGFloat           = 25.0
        helpButton.layer.cornerRadius       = cornerRadius
        loginButton.layer.cornerRadius      = cornerRadius
        questionsButton.layer.cornerRadius  = cornerRadius
    }
    
    private func confTableViews() {
        /* Cell Registration */
        dataTableView.register(CountryBaseInfoTVC.self)
        dataTableView.register(CityBaseInfoTVC.self)
    }
}
