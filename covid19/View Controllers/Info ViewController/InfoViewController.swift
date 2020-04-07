import UIKit
import Localize_Swift
import Firebase

class InfoViewController: UIViewController {
    // MARK: - Outlets
    
    // Labels
    @IBOutlet var titleLabel:   UILabel!
    
    // Buttons
    @IBOutlet var backButton:   UIButton!
    
    // Text Views
    @IBOutlet var textView:     UITextView!
    
    // MARK: -
    // MARK: - Variables
    
    var aboutCovid: AboutCovid!
    
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
        
        /*  Start the data listener */
        dataListener()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: -
    // MARK: - Data
    
    private func dataListener() {
        Firestore.firestore().collection("north_macedonia").document("about").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            self.dataProcess(document: document)
        }
    }
    
    private func dataProcess(document: DocumentSnapshot) {
        aboutCovid = AboutCovid(document: document)
        updateData()
    }
    
    // MARK: -
    // MARK: - UI Update
    
    private func updateData() {
        textView.text = aboutCovid.text
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func backButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: -
}
