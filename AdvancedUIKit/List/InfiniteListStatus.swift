/// InfiniteListStatus represents the status of an InfiniteList.
///
/// - version: 1.5.0
/// - date: 31/08/2018
/// - author: Adamas
enum InfiniteListStatus {
    
    /// The list has just been initialized.
    case initial
    
    /// More items are available.
    case infinite
    
    /// All items have been loaded.
    case finite
    
    /// No item is available.
    case empty
    
    /// More items are expected to be loaded.
    case loadingMore
    
    /// All items are expected to be reloaded.
    case reloading
}

extension InfiniteListStatus {
    
    /// Whether the edition and selection can be performed or not.
    var isStable: Bool {
        switch self {
        case .finite, .infinite, .empty:
            return true
        default:
            return false
        }
    }
    
    /// Check if a status transaction can happen or not.
    ///
    /// - Parameter status: The new status.
    /// - Returns: Checking result.
    func checkNextStatus(_ status: InfiniteListStatus) -> Bool {
        switch (self, status) {
        case (.initial, .infinite),
             (.initial, .finite),
             (.initial, .empty),
             (.infinite, .reloading),
             (.infinite, .loadingMore),
             (.finite, .reloading),
             (.empty, .reloading),
             (.loadingMore, .finite),
             (.loadingMore, .infinite),
             (.reloading, .infinite),
             (.reloading, .finite),
             (.reloading, .empty):
            return true
        default:
            let error = String(format: InfiniteListStatus.statusErrorPattern, "\(self)", "\(status)")
            Logger.standard.logError(error)
            return false
        }
    }
}

/// Constants
private extension InfiniteListStatus {
    
    /// System errors.
    static let statusErrorPattern = "Cannot switch status from %@ to %@."
}

import AdvancedFoundation
