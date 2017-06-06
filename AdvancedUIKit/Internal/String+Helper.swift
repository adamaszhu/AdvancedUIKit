/**
 * String+Helper provides additional functions for a string object.
 * - author: Adamas
 * - version: 1.0.1
 * - date: 20/04/2017
 */
extension String {
    
    /**
     * System warning.
     */
    private static let prefixWarning = "The prefix doesn't exist in the string."
    private static let suffixWarning = "The suffix doesn't exist in the string."
    
    /**
     * Remove a specific suffix from the string.
     * - parameter suffix: The suffix to be removed.
     */
    mutating func removeSuffix(_ suffix: String) {
        guard hasSuffix(suffix) else {
            Logger.standard.logWarning(String.suffixWarning, withDetail: suffix)
            return
        }
        let suffixBeginIndex = index(endIndex, offsetBy: -suffix.characters.count)
        let suffixRange = Range<String.Index>(uncheckedBounds: (lower: suffixBeginIndex, upper: endIndex))
        removeSubrange(suffixRange)
    }
    
    /**
     * Remove a specific prefix from the string.
     * - parameter prefix: The prefix to be removed.
     */
    mutating func removePrefix(_ prefix: String) {
        guard hasPrefix(prefix) else {
            Logger.standard.logWarning(String.prefixWarning, withDetail: prefix)
            return
        }
        let prefixEndIndex = index(startIndex, offsetBy: prefix.characters.count)
        let prefixRange = Range<String.Index>(uncheckedBounds: (lower: startIndex, upper: prefixEndIndex))
        removeSubrange(prefixRange)
    }
    
}

import Foundation
