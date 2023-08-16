/// CurrencyNumberRule presents the rule that a currency number string should follow. The string won't have a currency symbol.
///
/// - version: 1.9.18
/// - date: 16/08/23
/// - author: Adamas
public class CurrencyNumberRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// Initialize the rule
    /// - Parameter message: The error message to apply.
    public init(message: String) {
        self.message = message
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        guard let _ = NumberFormatterFactory
            .decimalFormatter()
            .number(from: value) else {
            return message
        }
        let components = value.split(separator: Self.decimalSeparator).map(String.init)
        return components[safe: 1]?.count == Self.centCount
        ? nil
        : message
    }
}

/// Constants
private extension CurrencyNumberRule {
    static let decimalSeparator: Character = "."
    static let centCount = 2
}

import AdvancedFoundation
import Foundation
