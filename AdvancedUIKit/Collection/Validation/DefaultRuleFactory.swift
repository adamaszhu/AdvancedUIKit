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

    /// Alphabet only rule
    /// - Parameter message: Error message
    /// - Returns: The rule
    public static func alphabetRule(withMessage message: String) -> RuleType {
        RegexRule(regex: Self.alphabetRegex, message: message)
    }
}

/// Constants
private extension DefaultRuleFactory {
    static let numberRegex = "^[0-9]*$"
    static let alphabetRegex = "^[a-zA-Z]*$"
}
