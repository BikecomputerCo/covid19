import UIKit
import Firebase

enum LoginType {
    case phoneNumber
    case email
}

class LoginViewController: UIViewController {
    // MARK: - Outlets
    
    // Views
    @IBOutlet var usernameView:     UIView!
    @IBOutlet var passwordView:     UIView!
    @IBOutlet var emailSepView:     UIView!
    @IBOutlet var phoneSepView:     UIView!
    
    // Labels
    @IBOutlet var usernameLabel:    UILabel!
    @IBOutlet var passwordLabel:    UILabel!
    @IBOutlet var phoneNumberField: PhoneNumberField!
    
    // Buttons
    @IBOutlet var loginButton:      LoadingButton!
    @IBOutlet var emailButton:      UIButton!
    @IBOutlet var phoneButton:      UIButton!
    
    // Text Fields
    @IBOutlet var usernameField:    UITextField!
    @IBOutlet var passwordField:    UITextField!
    
    // MARK: -
    // MARK: - Variables
    
    private var phoneNumber:        String?
    private var verificatonId:      String?
    
    var loginType                   = LoginType.email
    
    // MARK: -
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure */
        configure()
        
        /* Localization */
        updateTextForNewLocalization()
        
        /* Type */
        emailButtonAction(sender: emailButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Keyboard Observers */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Notifications */
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -
    // MARK: - Keyboard Modifiers
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }

    }

    @objc private func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    private func closeKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func loginButtonAction(sender: UIButton) {
        if loginType == .email {
            loginUserWithEmail()
        } else if loginType == .phoneNumber {
            loginUserWithPhoneNumber()
        }
    }
    
    @IBAction func emailButtonAction(sender: UIButton) {
        loginType = .email

        passwordLabel.isHidden  = false
        passwordView.isHidden   = false
        passwordField.isHidden  = false
        usernameField.isHidden = false
        
        usernameLabel.text = "Enter email".localized()
        phoneNumberField.isHidden = true
        passwordField.text = nil
        
        
        emailSepView.backgroundColor = UIColor.App.blue
        emailButton.setTitleColor(UIColor.App.blue, for: .normal)
        
        phoneSepView.backgroundColor = UIColor.App.black40
        phoneButton.setTitleColor(UIColor.App.black40, for: .normal)
        
        closeKeyboard()
    }
    
    @IBAction func phoneButtonAction(sender: UIButton) {
        loginType = .phoneNumber
        
        passwordLabel.isHidden  = true
        passwordView.isHidden   = true
        passwordField.isHidden  = true
        usernameField.isHidden = true
        
        usernameLabel.text = "Enter phone number".localized()
        phoneNumberField.isHidden = false
        phoneNumberField.text = nil
        
        
        emailSepView.backgroundColor = UIColor.App.black40
        emailButton.setTitleColor(UIColor.App.black40, for: .normal)
        
        phoneSepView.backgroundColor = UIColor.App.blue
        phoneButton.setTitleColor(UIColor.App.blue, for: .normal)
        
        closeKeyboard()
    }
    
    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
        closeKeyboard()
    }
    
    // MARK: - Networking
    
    private func loginUserWithPhoneNumber() {
        guard let validPhone = phoneNumberField.text, phoneNumberField.isValidNumber  else {
            showAlert(message: "The phone number that you entered is invalid".localized())
            return
        }

        performSegue(withIdentifier: "loginPhoneVerification", sender: validPhone)
    }
    
    private func loginUserWithEmail() {
        guard let email = usernameField.text, email.isValidEmail() else { return }
        guard let password = passwordField.text else { return }

        let credentials = EmailAuthProvider.credential(withEmail: email, password: password)
        login(credentials: credentials)
    }
    
    private func login(credentials: AuthCredential) {
        loginButton.startLoadingAnimation()
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.reset()
                return
             }
            
            self.loginSuccess()
        }
    }
    
    private func loginSuccess() {
        ConnectionsManager.shared.startPublishing()
        close()
    }
    
    // MARK: -
    // MARK: - UI
    
    private func reset() {
        DispatchQueue.main.async {
            self.usernameField.text = nil
            self.passwordField.text = nil
            self.verificatonId = nil
            self.phoneNumber = nil
            self.usernameField.isEnabled = true
            self.passwordView.isHidden   = false
        }
    }
    
    // MARK: -
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhoneVerificationViewController, let phoneNumber = sender as? String {
            controller.phoneNumber = phoneNumber
            controller.login = true
        }
    }
    
    @objc private func close() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - 
}
