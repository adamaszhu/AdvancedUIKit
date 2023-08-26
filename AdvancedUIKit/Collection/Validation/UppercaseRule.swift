/// UppercaseRule presents the rule that an uppercased string should follow.
///
/// - version: 1.10.0
/// - date: 26/08/23
/// - author: Adamas
public class UppercaseRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// Initialize the rule
    /// - Parameter message: The error message to apply.
    public init(message: String) {
        self.message = message
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        if value.uppercased() == value {
            return nil
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
