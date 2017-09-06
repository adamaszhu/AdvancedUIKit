/// String+Helper provides additional functions for a string object.
///
/// - author: Adamas
/// - version: 1.1.0
/// - date: 11/07/2017
extension String {
    
    /// Remove a specific suffix from the string.
    ///
    /// - Parameter suffix: The suffix to be removed.
    /// - Returns: Whether the suffix has been removed or not.
    @discardableResult
    mutating func remove(suffix: String) -> Bool {
        guard hasSuffix(suffix) else {
            return false
        }
        let suffixBeginIndex = index(endIndex, offsetBy: -suffix.characters.count)
        let suffixRange = Range<String.Index>(uncheckedBounds: (lower: suffixBeginIndex, upper: endIndex))
        removeSubrange(suffixRange)
        return true
    }
    
    /// Remove a specific prefix from the string.
    ///
    /// - Parameter prefix: The prefix to be removed.
    /// - Returns: Whether the prefix has been removed or not.
    @discardableResult
    mutating func remove(prefix: String) -> Bool {
        guard hasPrefix(prefix) else {
            return false
        }
        let prefixEndIndex = index(startIndex, offsetBy: prefix.characters.count)
        let prefixRange = Range<String.Index>(uncheckedBounds: (lower: startIndex, upper: prefixEndIndex))
        removeSubrange(prefixRange)
        return true
    }
    
}

import Foundation
