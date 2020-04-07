import UIKit
import Firebase
import Localize_Swift

class HelpViewController: UIViewController {
    // MARK: - Outlets
    
    // Labels
    @IBOutlet var titleLabel:       UILabel!
    
    // Table Views
    @IBOutlet var dataTableView:    UITableView!
    
    // MARK: -
    // MARK: - Variables
    
    var helpInfoData: [HelpInfo]    = []
    
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*  Start the data listener */
        dataListener()
    }
    
    // MARK: -
    // MARK: - Data
    
    private func dataListener() {
        Firestore.firestore().collection("north_macedonia/help_numbers/locations")
            .addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
                self.dataProcess(documents: querySnapshot.documents)
        }
    }
    
    private func dataProcess(documents: [DocumentSnapshot]) {
        var newHelpInfo: [HelpInfo] = []
        for document in documents {
            newHelpInfo.append(HelpInfo(document: document))
        }
        
        helpInfoData.removeAll()
        helpInfoData.append(contentsOf: newHelpInfo)

        updateData()
    }
    
    // MARK: -
    // MARK: - UI Update
    
    private func updateData() {
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    // MARK: -
}
