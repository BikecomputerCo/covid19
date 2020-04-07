import UIKit

class CountryBaseInfoTVC: UITableViewCell, Reusable, NibLoadable {
    
    // MARK: - Outlets
    
    // Views
    @IBOutlet private var curedView:                    UIView!
    @IBOutlet private var deathView:                    UIView!
    @IBOutlet private var sickView:                     UIView!
    @IBOutlet private var activeView:                   UIView!
    @IBOutlet private var totalView:                    UIView!
    
    @IBOutlet private var curedColorView:               UIView!
    @IBOutlet private var deathColorView:               UIView!
    @IBOutlet private var sickColorView:                UIView!
    @IBOutlet private var activeColorView:              UIView!
//    @IBOutlet private var toalColorView:                UIView!
    
    // Labels
    @IBOutlet private var titleLabel:                   UILabel!
    @IBOutlet private var dateLabel:                    UILabel!
    
    @IBOutlet private var curedTitleLabel:              UILabel!
    @IBOutlet private var curedPercentageLabel:         UILabel!
    @IBOutlet private var curedInfoLabel:               UILabel!
    
    @IBOutlet private var deathTitleLabel:              UILabel!
    @IBOutlet private var deathPercentageLabel:         UILabel!
    @IBOutlet private var deathInfoLabel:               UILabel!
    
    @IBOutlet private var sickTitleLabel:               UILabel!
    @IBOutlet private var sickPercentageLabel:          UILabel!
    @IBOutlet private var sickInfoLabel:                UILabel!
    
    @IBOutlet private var activeTitleLabel:             UILabel!
    @IBOutlet private var activePercentageLabel:        UILabel!
    @IBOutlet private var activeInfoLabel:              UILabel!
    
    @IBOutlet private var totalTitleLabel:              UILabel!
    @IBOutlet private var totalPercentageLabel:         UILabel!
    @IBOutlet private var totalInfoLabel:               UILabel!
    
    
    // MARK: -
    // MARK: - Variables
    
    var baseInfo: CountryBaseInfo? {
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
        let borderWidth: CGFloat            = 2.0
        let cornerRadius: CGFloat           = 8.0
        let colorViewCornerRadius: CGFloat  = 5.0
        
        curedView.layer.cornerRadius        = cornerRadius
        deathView.layer.cornerRadius        = cornerRadius
        sickView.layer.cornerRadius         = cornerRadius
        activeView.layer.cornerRadius       = cornerRadius
        totalView.layer.cornerRadius        = cornerRadius
        
        
        curedView.layer.borderWidth = borderWidth
        curedView.layer.borderColor = UIColor.App.gray.cgColor
        
        deathView.layer.borderWidth = borderWidth
        deathView.layer.borderColor = UIColor.App.gray.cgColor
        
        sickView.layer.borderWidth = borderWidth
        sickView.layer.borderColor = UIColor.App.gray.cgColor
        
        activeView.layer.borderWidth = borderWidth
        activeView.layer.borderColor = UIColor.App.gray.cgColor
        
        totalView.layer.borderWidth = borderWidth
        totalView.layer.borderColor = UIColor.App.gray.cgColor
        
        curedColorView.layer.cornerRadius   = colorViewCornerRadius
        deathColorView.layer.cornerRadius   = colorViewCornerRadius
        sickColorView.layer.cornerRadius    = colorViewCornerRadius
        activeColorView.layer.cornerRadius  = colorViewCornerRadius
    }
    
    // MARK: -
    // MARK: - Data
    
    private func displayData() {
        guard let validBaseInfo = baseInfo else { return }
        
        /* Number Formatter */
        let numberFormatter   = NumberFormatter(numberStyle: .none, locale: Locale.current)
        numberFormatter.set(numberStyle: .decimal, groupingSeparator: " ", decimalSeparator: ".")
        
        /* Date Formatter */
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: LocalizationManager.currentLocalization().rawValue)
        
        /* Info */
        let cured   = validBaseInfo.cured.format(formatter: numberFormatter) ?? "\(validBaseInfo.cured)"
        let death   = validBaseInfo.death.format(formatter: numberFormatter) ?? "\(validBaseInfo.death)"
        let sick    = validBaseInfo.sick.format(formatter: numberFormatter) ?? "\(validBaseInfo.sick)"
        let active  = validBaseInfo.active.format(formatter: numberFormatter) ?? "\(validBaseInfo.active)"
        let total   = validBaseInfo.total.format(formatter: numberFormatter) ?? "\(validBaseInfo.total)"
        
        let cured_percentage        = "\(calculatePercentage(totalValue: validBaseInfo.total, value: validBaseInfo.cured))%"
        let death_percentage        = "\(calculatePercentage(totalValue: validBaseInfo.total, value: validBaseInfo.death))%"
        let sick_percentage         = "\(calculatePercentage(totalValue: validBaseInfo.total, value: validBaseInfo.sick))%"
        let total_percentage        = "100%"
        let active_percentage       = "\(calculatePercentage(totalValue: validBaseInfo.total, value: validBaseInfo.active))%"
        
        let date                    = validBaseInfo.date
         
        /* Strings */
        titleLabel.text = "North Macedonia".localized()
        dateLabel.text  = "Official data for:".localized() + " " + dateFormatter.string(from: date)
        
        curedTitleLabel.text        = cured
        deathTitleLabel.text        = death
        sickTitleLabel.text         = sick
        activeTitleLabel.text       = active
        totalTitleLabel.text        = total
        
        curedPercentageLabel.text       = cured_percentage
        deathPercentageLabel.text       = death_percentage
        sickPercentageLabel.text        = sick_percentage
        activePercentageLabel.text      = active_percentage
        totalPercentageLabel.text       = total_percentage
        
        sickInfoLabel.text     = "Infected".localized()
        curedInfoLabel.text    = "Cured".localized()
        deathInfoLabel.text    = "Death".localized()
        activeInfoLabel.text   = "Active".localized()
        totalInfoLabel.text    = "Total".localized()
    }
    
    // MARK: -
    // MARK: - Private
    
    private func calculatePercentage(totalValue:Int, value:Int) -> String {
        let value = 100.0 - (Double(totalValue - value) / Double(totalValue) * 100.0)
        return String(format: "%.2f", value)
    }
    
    // MARK: -
}
