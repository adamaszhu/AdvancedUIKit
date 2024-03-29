/// CurrencyRule presents the rule that a currency string should follow.
///
/// - version: 1.10.0
/// - date: 19/09/22
/// - author: Adamas
public class CurrencyRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// Number formatters in different locale
    private let numberFormatters: [NumberFormatter]

    /// Initialize the rule
    /// - Parameters:
    ///   - languages: The language region that the currency can be in 
    ///   - message: The error message to apply.
    public init(languages: [Language],
                message: String) {
        self.message = message
        numberFormatters = languages.map { NumberFormatterFactory.currencyFormatter(for: $0) }
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        for numberFormatter in numberFormatters {
            if let _ = Double(currency: value, numberFormatter: numberFormatter) {
                return nil
            }
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
