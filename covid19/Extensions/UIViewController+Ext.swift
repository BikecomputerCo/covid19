import UIKit

extension UIViewController {
    // MARK: - Alerts
    
    func showAlert(message: String?) {
        showAlert(title: nil, message: message)
    }
    
    func showAlert(title: String?, message: String?, animated: Bool = true) {
        showAlert(title: title, message: message, animated: animated, completition: nil)
    }
    
    func showAlert(title: String?, message: String?, animated: Bool = true, completition: (() -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: .default, handler: { (_) in
            completition?()
        }))
           
        DispatchQueue.main.async {
            self.present(alert, animated: animated, completion: nil)
        }
    }
    
    func showConfirmationAlert(title: String?,
                               message: String?,
                               confirmActionName: String = "Okay".localized(),
                               cancelActionName: String = "Cancel".localized(),
                               animated: Bool = true,
                               completition: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction   = UIAlertAction(title: confirmActionName, style: .default) { (_) in completition(true) }
        let cancelAction    = UIAlertAction(title: cancelActionName, style: .cancel) { (_) in completition(false) }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: animated, completion: nil)
        }
    }
    
    // MARK: -
}
