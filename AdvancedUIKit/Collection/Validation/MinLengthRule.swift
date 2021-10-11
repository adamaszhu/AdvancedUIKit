/// MinLengthRule presents the min length requirement that a text field value should follow.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class MinLengthRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// The min length that the value should meet.
    private let minLength: Int

    /// Initialize the rule
    /// - Parameters:
    ///   - minLength: The min length of the value.
    ///   - message: sage: The error message to apply.
    public init(minLength: Int, message: String) {
        self.message = message
        self.minLength = minLength
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        return value.count < minLength ? message : nil
    }
}
