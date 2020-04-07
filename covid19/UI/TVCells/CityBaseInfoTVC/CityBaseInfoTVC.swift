import UIKit

class CityBaseInfoTVC: UITableViewCell, Reusable, NibLoadable {
        
    // MARK: - Outlets
        
    // Views
    @IBOutlet private var mainView:                     UIView!
        
    // Labels
    @IBOutlet private var titleLabel:                   UILabel!
    
    @IBOutlet private var curedTitleLabel:              UILabel!
    @IBOutlet private var curedInfoLabel:               UILabel!
    
    @IBOutlet private var deathTitleLabel:              UILabel!
    @IBOutlet private var deathInfoLabel:               UILabel!
    
    @IBOutlet private var sickTitleLabel:               UILabel!
    @IBOutlet private var sickInfoLabel:                UILabel!
    
    @IBOutlet private var activeTitleLabel:             UILabel!
    @IBOutlet private var activeInfoLabel:              UILabel!
    
    // MARK: -
    // MARK: - Variables
    
    // Public
    var baseInfo: CityBaseInfo? {
        didSet {
            displayData()
        }
    }
            
    // MARK: -
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        /* Configurations */
        configureViews()
    }
    
    // MARK: -
    // MARK: - Configuration
    
    private func configureViews() {
        mainView.layer.cornerRadius = 8.0
        
        mainView.layer.borderWidth = 2.0
        mainView.layer.borderColor = UIColor.App.gray.cgColor
    }
        
    // MARK: -
    // MARK: - Data
    
    private func displayData() {
        guard let validBaseInfo = baseInfo else { return }
        
        /* Number Formatter */
        let numberFormatter   = NumberFormatter(numberStyle: .none, locale: Locale.current)
        numberFormatter.set(numberStyle: .decimal, groupingSeparator: " ", decimalSeparator: ".")
        
        /* Info */
        let cured   = validBaseInfo.cured.format(formatter: numberFormatter) ?? "\(validBaseInfo.cured)"
        let death   = validBaseInfo.death.format(formatter: numberFormatter) ?? "\(validBaseInfo.death)"
        let sick    = validBaseInfo.sick.format(formatter: numberFormatter) ?? "\(validBaseInfo.sick)"
        let active  = validBaseInfo.active.format(formatter: numberFormatter) ?? "\(validBaseInfo.active)"
        
         
        /* Strings */
        titleLabel.text =  validBaseInfo.city.value
        
        curedTitleLabel.text        = cured
        deathTitleLabel.text        = death
        sickTitleLabel.text         = sick
        activeTitleLabel.text       = active
        
        sickInfoLabel.text     = "Infected".localized()
        curedInfoLabel.text    = "Cured".localized()
        deathInfoLabel.text    = "Death".localized()
        activeInfoLabel.text   = "Active".localized()
    }
    
    // MARK: -
}
