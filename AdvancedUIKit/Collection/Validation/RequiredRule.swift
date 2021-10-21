/// RequiredRule presents the required rule that a text field value should follow.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class RequiredRule: RuleType {
    
    /// The error message to return if the validation fails.
    private let message: String

    /// Initialize the rule
    /// - Parameter message: The error message to apply. 
    public init(message: String) {
        self.message = message
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        return value.isEmpty ? message : nil
    }
}
