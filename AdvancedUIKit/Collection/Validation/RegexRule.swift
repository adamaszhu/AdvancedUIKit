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

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        let result = value.range(of: regex, options: .regularExpression)
        return result != nil ? nil : message
    }
}
