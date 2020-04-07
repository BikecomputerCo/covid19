import UIKit

extension UIColor {
    struct App {
        static let blue             = UIColor(displayP3Red: 48/255.0, green: 130/255.0, blue: 229/255.0, alpha: 1.0)
        static let gray             = UIColor(displayP3Red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        static let orange           = UIColor(displayP3Red: 255/255.0, green: 170/255.0, blue: 81/255.0, alpha: 1.0)
    
        
        /* Black variations */
        static var black100:    UIColor { return UIColor.App.black(100.0) }
        static var black40:     UIColor { return UIColor.App.black(40.0) }
        static var black20:     UIColor { return UIColor.App.black(20.0) }
        static var black10:     UIColor { return UIColor.App.black(10.0) }
        
        static private func black(_ alpha: CGFloat) -> UIColor {
            return UIColor(displayP3Red: 2/255.0, green: 10/255.0, blue: 28/255.0, alpha: alpha)
        }
    }
}
