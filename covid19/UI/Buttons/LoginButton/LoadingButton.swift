import UIKit

class LoadingButton: UIButton {
    // MARK: - Variables
    
    private let activityIndicator   = UIActivityIndicatorView(style: .white)
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: -
    // MARK: - Configuration
    
    private func configure() {
        configureActivityIndicators()
    }
    
    private func configureActivityIndicators() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        activityIndicator.color = .white
        
        addSubview(activityIndicator)
    }
    
    // MARK: -
    // MARK: - Public
    
    func startLoadingAnimation() {
        setTitle(nil, for: .normal)
        
        activityIndicator.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
    }
    
    func stopLoadingAnimation(title: String) {
        setTitle(title, for: .normal)
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
    }
    
    // MARK: -
}
