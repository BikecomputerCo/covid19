import UIKit
import Firebase

class ThanksViewController: UIViewController {
    // MARK: - Outlets
    
    // Labels
    @IBOutlet var titleLabel:           UILabel!
    @IBOutlet var descriptionLabel:     UILabel!
       
    // Button
    @IBOutlet var backButton:           UIButton!
       
    // MARK: -
    // MARK: - Variables
    
    var answers: [Answer] = []
       
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
        
        /* Data */
        saveAnswers()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction private func backButtonAction(button: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: -
    // MARK: - Data
    
    private func saveAnswers() {
        let formatedAnswers = answers.map { (answer) -> [String: Any] in
            return [
                "question": answer.question,
                "description": answer.description,
                "answer": answer.answer
            ]
        }
        
        let data: [String: Any] = [
            "date": FieldValue.serverTimestamp(),
            "answers": formatedAnswers
        ]
        

        if let userID = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("users").document(userID).collection("answers").addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: -
}
