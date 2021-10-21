/// RuleType presents a rule that a text field value should follow.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
public protocol RuleType: AnyObject {

    /// Check if a given value is valid
    /// - Parameter value: The value to check
    /// - Returns: The error message if the value is invalid
    func isValid(value: String?) -> String?
}
