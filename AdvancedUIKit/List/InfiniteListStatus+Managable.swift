/**
 * InfiniteListStatus+Managable defines which actions are availabled under a status.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/07/2017
 */
extension InfiniteListStatus {
    
    /**
     * System error.
     */
    static let registerAvailabilityError = "Register components without initial status."
    
    /**
     * System warning.
     */
    static let reloadStatusWarning = "Reload items without reloading status."
    static let loadMoreStatusWarning = "Load more items without loading more status."
    static let selectAvailabilityWarning = "The status doesn't allow selecting an item."
    static let reloadAvailabilityWarning = "The status doesn't allow reloading items."
    static let loadMoreAvailabilityWarning = "The status doesn't allow loading more items."
    static let editAvailabilityWarning = "The status doesn't allow edit an item."
    
    /**
     * Whether the reloading status has been settled or not.
     */
    var isReloading: Bool {
        switch self {
        case .initial, .reloading:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadStatusWarning)
            return false
        }
    }
    
    /**
     * Whether the loading more status has been settled or not.
     */
    var isLoadingMore: Bool {
        switch self {
        case .loadingMore:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadMoreStatusWarning)
            return false
        }
    }
    
    /**
     * Whether the reloading status can be settled or not.
     */
    var isReloadingAvailable: Bool {
        switch self {
        case .infinite, .finite, .empty:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadAvailabilityWarning)
            return false
        }
    }
    
    /**
     * Whether the loading more status can be settled or not.
     */
    var isLoadingMoreAvailable: Bool {
        switch self {
        case .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadMoreAvailabilityWarning)
            return false
        }
    }
    
    /**
     * Whether the selection can be performed or not.
     */
    var isSelectingAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.selectAvailabilityWarning)
            return false
        }
    }
    
    /**
     * Whether the edition can be performed or not.
     */
    var isEditingAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.editAvailabilityWarning)
            return false
        }
    }
    
    /**
     * Whether register is available or not.
     */
    var isRegisteringAvailable: Bool {
        switch self {
        case .initial:
            return true
        default:
            Logger.standard.logError(InfiniteListStatus.registerAvailabilityError)
            return false
        }
    }
    
}
