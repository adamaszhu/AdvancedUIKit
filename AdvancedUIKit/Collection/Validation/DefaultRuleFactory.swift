/// DefaultRuleFactory provides some generic rules.
///
/// - version: 1.8.0
/// - date: 14/09/22
/// - author: Adamas
public class DefaultRuleFactory {

    /// Number only rule
    /// - Parameter message: Error message
    /// - Returns: The rule
    public static func numberRule(withMessage message: String) -> RuleType {
        RegexRule(regex: Self.numberRegex, message: message)
    }

    /// Barcode only rule
    /// - Parameter message: Error message
    /// - Returns: The rule
    public static func barcodeRule(withMessage message: String) -> RuleType {
        RegexRule(regex: Self.barcodeRegex, message: message)
    }

    /// Alphabet only rule
    /// - Parameter message: Error message
    /// - Returns: The rule
    public static func alphabetRule(withMessage message: String) -> RuleType {
        RegexRule(regex: Self.alphabetRegex, message: message)
    }

    /// Full name rules
    /// - Parameter message: Error message
    /// - Returns: A list of rules that a full name should follow
    public static func fullNameRules(withMessage message: String) -> [RuleType] {
        [RegexRule(regex: Self.fullNameRegex, message: message)]
    }

    /// Credit card verification number rules
    /// - Parameters:
    ///   - invalidMessage: Message for a invalid string
    ///   - lengthMessage: Message for a string with invalid length
    /// - Returns: A list of rules that a credit card verification number should follow
    public static func creditCardVerificationNumberRules(withInvalidMessage invalidMessage: String,
                                                         andLengthMessage lengthMessage: String) -> [RuleType] {
        [numberRule(withMessage: invalidMessage),
         MinLengthRule(minLength: Self.creditCardVerificationNumberLength,
                       message: lengthMessage),
         MaxLengthRule(maxLength: Self.creditCardVerificationNumberLength,
                       message: lengthMessage)]
    }

    /// Expiry date rules
    /// - Parameter message: Error message
    /// - Returns: A list of fules that a expiry string should follow
    public static func expiryRules(withMessage message: String) -> [RuleType] {
        [MinDateRule(minDate: Date(),
                     dateFormats: [.expiryDate, .fullExpiryDate],
                     message: message)]
    }

    public static func creditCardNumberRules(withInvalidMessage invalidMessage: String,
                                             minLengthMessage: String,
                                             andMaxLengthMessage maxLengthMessage: String) -> [RuleType] {
        [numberRule(withMessage: invalidMessage),
         MinLengthRule(minLength: Self.creditCardNumberMinLength,
                       message: minLengthMessage),
         MaxLengthRule(maxLength: Self.creditCardNumberMaxLength,
                       message: maxLengthMessage),
         LuhnRule(message: invalidMessage)]
    }

    /// Currency string rule
    /// - Parameters:
    ///   - languages: Languages that the currency string can be in
    ///   - message: Error messagee
    /// - Returns: The rule
    public static func currencyRules(for languages: [Language],
                                     withMessage message: String) -> [RuleType] {
        [UnionRule(rules: [CurrencyRule(languages: languages, message: message),
                           CurrencyNumberRule(message: message)],
                   message: message)]
    }
}

/// Constants
private extension DefaultRuleFactory {
    static let creditCardNumberMinLength = 13
    static let creditCardNumberMaxLength = 16
    static let creditCardVerificationNumberLength = 3
    static let fullNameRegex = "^([A-Z][-.a-zA-Z]+[ ]{1})+[A-Z][-.a-zA-Z]+$"
    static let numberRegex = "^\d*$"
    static let barcodeRegex = "^\d{13}|\d{12}|\d{8}$"
    static let alphabetRegex = "^[a-zA-Z]*$"
}

import Foundation
import AdvancedFoundation
