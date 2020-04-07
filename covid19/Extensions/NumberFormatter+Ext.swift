import Foundation

extension NumberFormatter {
    convenience init(numberStyle: NumberFormatter.Style, groupingSeparator: String?, decimalSeparator: String?) {
        self.init()
        set(numberStyle: numberStyle, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
    }

    convenience init(numberStyle: NumberFormatter.Style, locale: Locale) {
        self.init()
        set(numberStyle: numberStyle, locale: locale)
    }

    func set(numberStyle: NumberFormatter.Style, groupingSeparator: String?, decimalSeparator: String?) {
        self.locale = nil
        self.numberStyle = numberStyle
        self.groupingSeparator = groupingSeparator
        self.decimalSeparator = decimalSeparator
    }

    func set(numberStyle: NumberFormatter.Style, locale: Locale?) {
        self.numberStyle = numberStyle
        self.locale = locale
    }
}

extension String { var toLocale: Locale { return Locale(identifier: self) } }

extension Numeric {
    func format(formatter: NumberFormatter) -> String? {
        if let num = self as? NSNumber { return formatter.string(from: num) }
        return nil
    }
}
