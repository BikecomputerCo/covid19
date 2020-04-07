import Foundation
import Localize_Swift

extension StartViewController {
    // MARK: - Functions
    
    @objc func updateTextForNewLocalization() {
        title = "Current situation".localized()
        
        loginButton.setTitle("Login".localized(), for: .normal)
        registerButton.setTitle("Don't have account? Register now!".localized(), for: .normal)
        helpButton.setTitle("Help".localized(), for: .normal)
        questionsButton.setTitle("Answer Questions".localized(), for: .normal)
        
        dataTableView.reloadData()
    }
    
    // MARK: -
}
