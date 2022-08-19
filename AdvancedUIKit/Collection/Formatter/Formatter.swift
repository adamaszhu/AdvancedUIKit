/// Formatter defines the function to format a string.
///
/// - version: 1.10.0
/// - date: 13/07/22
/// - author: Adamas
public protocol Formatter {

    /// Format the value to a more user friendly one
    /// - Parameter value: The current value
    /// - Returns: The formatted value
    func format(_ value: String) -> String

    /// Remove any formatting applied and get the original value
    /// - Parameter value: The formatted value
    /// - Returns: The original value
    func removeFormatting(_ value: String) -> String
}
