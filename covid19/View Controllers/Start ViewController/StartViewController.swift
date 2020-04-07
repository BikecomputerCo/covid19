import UIKit
import Firebase
import Localize_Swift

class StartViewController: UIViewController {
    // MARK: - Outlets
    
    // Views
    @IBOutlet var registerSep:      UIView!
        
    // Buttons
    @IBOutlet var helpButton:       UIButton!
    @IBOutlet var loginButton:      UIButton!
    @IBOutlet var registerButton:   UIButton!
    @IBOutlet var questionsButton:  UIButton!
    
    // Table Views
    @IBOutlet var dataTableView:    UITableView!
    
    // Constraint
    @IBOutlet var bottomConst:      NSLayoutConstraint!
    
    // MARK: -
    // MARK: - Variables
    
    var countryInfo: CountryBaseInfo?
    var cities: [CityBaseInfo]      = []
    
    private var lastQuestionDate: Date?
    private var firestore: Firestore?
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure */
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Navigation Bar */
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        /* Localization */
        updateTextForNewLocalization()
        
        /* Update UI for user change */
        updateUIforUserChange()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Init firestore */
        if firestore == nil {
            firestore = Firestore.firestore()
        }
        
        /*  Start the data listener */
        dataListener()
        checkQuestions()
    }
    
    // MARK: -
    // MARK: - Data
    
    private func dataListener() {
        firestore?.collection("north_macedonia").document("base_info").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            guard let _ = document.data() else { return }
            self.countryDataProcess(document: document)
        }
        
        firestore?.collection("north_macedonia/base_info/cities")
            .addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
                self.citiesDataProcess(documents: querySnapshot.documents)
        }
    }
    
    private func countryDataProcess(document: DocumentSnapshot) {
        countryInfo = CountryBaseInfo(document: document)
        updateData()
    }
    
    private func citiesDataProcess(documents: [DocumentSnapshot]) {
        var data: [CityBaseInfo] = []
        for document in documents {
            data.append(CityBaseInfo(document: document))
        }
        
        cities.removeAll()
        cities.append(contentsOf: data)

        updateData()
    }
    
    private func checkQuestions() {
        if let user = Auth.auth().currentUser {
            firestore?.collection("users/\(user.uid)/answers").order(by: "date").limit(to: 1).getDocuments(completion: { (querySnapshot, errpr) in
                guard let querySnapshot = querySnapshot, querySnapshot.documents.count > 0 else { return }
                let document = querySnapshot.documents[0]
                self.lastQuestionDate = (document["date"] as? Timestamp)?.dateValue()
                self.updateQuestionsUI()
            })
        }
        
    }
    
    // MARK: -
    // MARK: - UI Update
    
    private func updateData() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    func updateQuestionsUI() {
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser, !user.isAnonymous else {
                self.questionsButton.isHidden = true
                return
            }
            
            if let date = self.lastQuestionDate, Calendar.current.isDateInToday(date) {
                self.questionsButton.isHidden = true
            } else {
                self.questionsButton.isHidden = false
            }
        }
    }
    
    func updateUIforUserChange() {
        if let user = Auth.auth().currentUser {
            loginButton.isHidden    = !user.isAnonymous
            registerButton.isHidden = !user.isAnonymous
            registerSep.isHidden    = !user.isAnonymous
            
            updateQuestionsUI()
            
            if user.isAnonymous {
                bottomConst.constant = 15
                navigationItem.rightBarButtonItem = nil
            } else {
                bottomConst.constant = -15
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_account_circle_blue"), style: .done, target: self, action: #selector(openProfile))
            }
        }
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func openProfile() {
        performSegue(withIdentifier: "openProfile", sender: nil)
    }
    
    @IBAction func openQuestions() {
        performSegue(withIdentifier: "openQuestions", sender: nil)
    }
    
    // MARK: -
}
