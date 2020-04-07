import UIKit
import Localize_Swift
import PhoneNumberKit
import Firebase

class RegisterViewController: UIViewController {
    // MARK: - Outlets
    
    // Labels
    @IBOutlet var titleLabel:       UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var emailTitle:       UILabel!
    @IBOutlet var passwordTitle:    UILabel!
    @IBOutlet var phoneNumberTitle: UILabel!
    
    // Buttons
    @IBOutlet var registerButton:   LoadingButton!
    @IBOutlet var backButton:       UIButton!
    
    // Text Fields
    @IBOutlet var emailField:       UITextField!
    @IBOutlet var passwordField:    UITextField!
    @IBOutlet var phoneNumberField: PhoneNumberField!
    
    // Constraints
    @IBOutlet var emailTitleTopCon: NSLayoutConstraint!
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure */
        configure()
        
        /* Localization */
        updateTextForNewLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Navigation Bar */
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Keyboard Observers */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Remove Observers */
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: -
    // MARK: - Keyboard Modifiers
    
    @objc private func keyboardWillShow(notification: Notification) {
         emailTitleTopCon.isActive = false
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.alpha = 0.0
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        emailTitleTopCon.isActive = true
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
    
    private func closeKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction private func registerButtonAction(sender: UIButton) {
        starUserRegistration()
    }
    
    @IBAction private func backButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
        closeKeyboard()
    }
    
    // MARK: -
    // MARK: - Network
    
    func starUserRegistration() {
        guard let email = emailField.text, email.isValidEmail() else {
            showAlert(message: "Please enter a valid email address".localized())
            return
        }
        
        guard let password = passwordField.text, password.isValidPassword() == nil else {
            let message = passwordField.text?.isValidPassword()
            showAlert(message: message)
            return
        }
        
        if let phoneValue = phoneNumberField.text {
            /* Phone number available */
            if phoneValue == "" || phoneValue == "+389" {
                /* Phone number not edited */
                registerUser(email: email, password: password, phone: nil)
            } else if !phoneNumberField.isValidNumber {
                /* Phone number is ivalid */
                showConfirmationAlert(title:nil, message: "The phone number that you entered is invalid".localized(), confirmActionName: "Try Again".localized(), cancelActionName: "Proced without phone number".localized()) { (result) in
                    if result {
                        self.phoneNumberField.text = "+389 "
                        self.phoneNumberField.becomeFirstResponder()
                    } else {
                        self.registerUser(email: email, password: password, phone: nil)
                    }
                }
            } else {
                /* Phone number is valid */
                registerUser(email: email, password: password, phone: phoneValue)
            }
        } else {
            /* Phone number not available */
            registerUser(email: email, password: password, phone: nil)
        }
    }
    
    private func registerUser(email: String, password: String, phone: String?) {
        guard let user = Auth.auth().currentUser, user.isAnonymous else { return }
        
        registerButton.startLoadingAnimation()
        let emailCredentials = EmailAuthProvider.credential(withEmail: email, password: password)
        user.link(with: emailCredentials) { (result, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.reset()
                return
            }
            
            if let validPhone = phone {
                self.validatePhoneNumber(phoneNumber: validPhone)
            } else {
                self.openApplication()
            }
        }
    }
    
    // MARK: -
    // MARK: - Navigation
    
    private func openApplication() {
        ConnectionsManager.shared.startPublishing()
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func validatePhoneNumber(phoneNumber: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "phoneVerification", sender: phoneNumber)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhoneVerificationViewController, let phoneNumber = sender as? String {
            controller.phoneNumber = phoneNumber
        }
    }
    
    // MARK: -
    // MARK: - UI
    
    private func reset() {
        DispatchQueue.main.async {
            self.registerButton.stopLoadingAnimation(title: "Register".localized())
        }
    }
    
    // MARK: -
}
