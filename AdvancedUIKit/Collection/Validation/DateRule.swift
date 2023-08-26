/// DateRule presents the date requirement that a date string should follow.
///
/// - version: 1.9.6
/// - date: 14/09/22
/// - author: Adamas
public class DateRule: RuleType {

    /// The error message to return if the validation fails.
    let message: String

    /// Supported date formats
    let dateFormats: [DateFormatType]

    /// Initialize the rule
    /// - Parameters:
    ///   - dateFormats: A list of format supported by the rule
    ///   - message: The error message to apply.
    public init(dateFormats: [DateFormatType], message: String) {
        self.dateFormats = dateFormats
        self.message = message
    }

    public func isValid(value: String?) -> String? {
        let value = value ?? String()
        for dateFormat in dateFormats {
            if Date(string: value, dateFormat: dateFormat) != nil {
                return nil
            }
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
