/// MinDateRule presents the min date requirement that a date string should follow.
///
/// - version: 1.9.9
/// - date: 19/09/22
/// - author: Adamas
public class MinDateRule: DateRule {

    /// The min date
    private let minDate: Date

    /// Initialize the rule
    /// - Parameters:
    ///   - minDate: The min date
    ///   - dateFormats: A list of format supported by the rule
    ///   - message: The error message to apply.
    public init(minDate: Date, dateFormats: [DateFormat], message: String) {
        self.minDate = minDate
        super.init(dateFormats: dateFormats, message: message)
    }

    public override func isValid(value: String?) -> String? {
        let value = value ?? String()
        for dateFormat in dateFormats {
            if let date = Date(string: value, dateFormat: dateFormat),
            date >= minDate {
                return nil
            }
        }
        return message
    }
}

import AdvancedFoundation
import Foundation
