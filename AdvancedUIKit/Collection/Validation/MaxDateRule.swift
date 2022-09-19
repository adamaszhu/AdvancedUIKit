/// MaxDateRule presents the max date requirement that a date string should follow.
///
/// - version: 1.9.9
/// - date: 19/09/22
/// - author: Adamas
public class MaxDateRule: DateRule {

    /// The max date
    private let maxDate: Date

    /// Initialize the rule
    /// - Parameters:
    ///   - maxDate: The max date
    ///   - dateFormats: A list of format supported by the rule
    ///   - message: The error message to apply.
    public init(maxDate: Date, dateFormats: [DateFormat], message: String) {
        self.maxDate = maxDate
        super.init(dateFormats: dateFormats, message: message)
    }

    public override func isValid(value: String?) -> String? {
        let value = value ?? String()
        for dateFormat in dateFormats {
            if let date = Date(string: value, dateFormat: dateFormat),
            date <= maxDate {
                return nil
            }
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
