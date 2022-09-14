/// RegexRule presents a regex that a text field value should follow.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class RegexRule: RuleType {

    /// The regex that the value should follow.
    private let regex: String

    /// The error message to return if the validation fails.
    private let message: String

    /// Initialize the rule
    /// - Parameters:
    ///   - regex: The regex expression.
    ///   - message: The error message to apply.
    public init(regex: String, message: String) {
        self.regex = regex
        self.message = message
    }

    /// Initialize the rule
    /// - Parameters:
    ///   - regexes: A list of regexes. The rule will pass if any of them is matched.
    ///   - message: The error message to apply.
    public init(regexes: [String], message: String) {
        regex = regexes
            .map { String(format: Self.regexPattern, $0) }
            .joined(separator: Self.unionSymbol)
        self.message = message
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        let result = value.range(of: regex, options: .regularExpression)
        return result != nil ? nil : message
    }
}

/// Constants
private extension RegexRule {
    static let regexPattern = "(%@)"
    static let unionSymbol = "|"
}
