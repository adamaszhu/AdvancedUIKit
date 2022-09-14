/// MaxLengthRule presents the min length requirement that a text field value should follow.
///
/// - version: 1.8.0
/// - date: 13/09/22
/// - author: Adamas
open class MaxLengthRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// The max length that the value should meet.
    private let maxLength: Int

    /// Initialize the rule
    /// - Parameters:
    ///   - maxLength: The max length of the value.
    ///   - message: sage: The error message to apply.
    public init(maxLength: Int, message: String) {
        self.message = message
        self.maxLength = maxLength
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        return value.count > maxLength ? message : nil
    }
}
