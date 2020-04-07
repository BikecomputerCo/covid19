import Foundation
import PhoneNumberKit

class PhoneNumberField: PhoneNumberTextField {
    override var defaultRegion: String {
        get { return "MK" }
        set {}
    }
}
