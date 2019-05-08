/// Array+Accessor provides additional support to access the array.
///
/// - author: Adamas
/// - version: 1.1.0
/// - date: 07/09/2017
extension Array {
    
    /// System error.
    private static var indexError: String { return "The index is out of rage." }
    
    /// Get the element at an index with index checking.
    ///
    /// - Parameter index: The index.
    /// - Returns: The element. Nil if the index is invalid.
    func element(atIndex index: Int) -> Element? {
        guard 0 ..< count ~= index else {
            Logger.standard.logError(Array.indexError, withDetail: index)
            return nil
        }
        return self[index]
    }
    
}

import Foundation
