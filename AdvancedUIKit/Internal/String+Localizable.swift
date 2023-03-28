/// String+Localizable localizes a string.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 23/03/2019
internal extension String {
    
    /// Localize a string using the localization file as the class name within current framework.
    ///
    /// - Parameter type: Any structure or class used to find the localization file.
    /// - Returns: The localized string.
    func localizedInternalString(forType type: Any) -> String {
        NSLocalizedString(self,
                          tableName: String(describing: type),
                          bundle: .current,
                          comment: .empty)
    }
}

import Foundation
