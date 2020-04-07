import Foundation

protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable {    
    static var nibName: String {
        return String(describing: self)
    }
}
