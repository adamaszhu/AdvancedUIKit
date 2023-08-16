/// Union several rules where the validation will pass when one of the rules is satisfied
///
/// - version: 1.9.19
/// - date: 16/08/23
/// - author: Adamas
public class UnionRule: RuleType {

    /// The error message to return if the validation fails.
    private let message: String

    /// A collection of rules
    private let rules: [RuleType]

    /// Initialize the rule
    /// - Parameters:
    ///   - rules: A list of rules to check 
    ///   - message: The error message to apply.
    public init(rules: [RuleType],
                message: String) {
        self.message = message
        self.rules = rules
    }

    public func isValid(value: String?) -> String? {
        for rule in rules {
            if rule.isValid(value: value) == nil {
                return nil
            }
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
