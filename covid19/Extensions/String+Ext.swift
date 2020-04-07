import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex =
        "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let predicate = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isValidPassword() -> String? {
        if self.count < 8 { return "Your password must be at least 8 character long".localized() }
        if self.count > 20 { return "Your password can't be bigger than 20 character long".localized() }
        if self.lowercased() == self { return "Your password must contain at least 1 uppercased character".localized() }
        if self.uppercased() == self { return "Your password must contain at least 1 lowercased character".localized() }
        if rangeOfCharacter(from: .decimalDigits) == nil { return "Your password must contain at least 1 number".localized() }
        
        return nil
    }
}

