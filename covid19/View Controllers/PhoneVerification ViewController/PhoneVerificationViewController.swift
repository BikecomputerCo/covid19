import UIKit
import Firebase

class PhoneVerificationViewController: UIViewController {
    // MARK: - Outlets
       
    // Views
    @IBOutlet var coverView:            UIView!
    
    // Labels
    @IBOutlet var titleLabel:           UILabel!
    @IBOutlet var noCodeLabel:          UILabel!
       
    // Buttons
    @IBOutlet var confirmButton:        LoadingButton!
    @IBOutlet var resendCodeButton:     LoadingButton!
    @IBOutlet var cancelButton:         UIButton!
       
    // Text Fields
    @IBOutlet var codeField:             UITextField!
       
    // MARK: -
    // MARK: - Variables
    
    // Public
    var phoneNumber: String = ""
    var login: Bool = false
    
    // Private
    private var verificationId: String?
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure */
        configure()
        
        /* Localization */
        updateTextForNewLocalization()
        
        /* Verify Phone*/
        verifyPhoneNumber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Navigation Bar */
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Make field active */
        codeField.becomeFirstResponder()
        
        /* Schedule */
        if login {
            showCancelButton()
        } else {
            perform(#selector(showCancelButton), with: nil, afterDelay: 7.0)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Cancel Scheduler */
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }

    // MARK: -
    // MARK: - Actions
    
    @IBAction private func confirmButtonAction(sender: UIButton) {
        if login {
            loginUser()
        } else {
            linkPhoneToUser()
        }
    }
    
    @IBAction private func resendButtonAction(sender: UIButton) {
        coverView.isHidden = false
        verifyPhoneNumber()
    }
    
    @IBAction private func cancelButtonAction(sender: UIButton) {
        openApplication()
    }
    
    // MARK: -
    // MARK: - Network
    
    private func verifyPhoneNumber() {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                if self.login {
                    self.perform(#selector(self.back), with: nil, afterDelay: 0.4)
                } else {
                    self.perform(#selector(self.openApplication), with: nil, afterDelay: 0.4)
                }
                
                return
            }
            
            /* Schedule */
            self.perform(#selector(self.showResendButton), with: nil, afterDelay: 20.0)
            self.verificationId = verificationID
        }
    }
    
    private func linkPhoneToUser() {
        guard let user = Auth.auth().currentUser, !user.isAnonymous else { fatalError() }
        guard let verificationId = verificationId else { fatalError() }
        guard let code = codeField.text, code.count > 5 else {
            showAlert(message: "Please enter a valid code".localized())
            return
        }
        
        confirmButton.startLoadingAnimation()
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode:code)
        user.link(with: credentials) { (result, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.reset()
                return
            }
            
            self.linkSuccesfull()
        }
    }
    
    private func loginUser() {
        guard let verificationId = verificationId else { return }
        guard let code = codeField.text, code.count > 5 else {
            showAlert(message: "Please enter a valid code".localized())
            return
        }
        
        confirmButton.startLoadingAnimation()
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode:code)
        Auth.auth().signIn(with: credentials) { (result, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.reset()
                return
            }
        }
        
        self.loginSuccesfull()
    }
    
    // MARK: -
    // MARK: - Other
    
    @objc private func showResendButton() {
        coverView.isHidden = true
    }
    
    @objc private func showCancelButton() {
        cancelButton.isHidden = false
    }
    
    private func linkSuccesfull() {
        self.openApplication()
    }
    
    private func loginSuccesfull() {
        self.openApplication()
    }
    
    @objc private func openApplication() {
        ConnectionsManager.shared.startPublishing()
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func back() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: -
    // MARK: - UI
    
    private func reset() {
        DispatchQueue.main.async {
            self.confirmButton.stopLoadingAnimation(title: "Confirm".localized())
        }
    }
    
    // MARK: -
}
