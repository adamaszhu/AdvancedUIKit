/// InfiniteListStatus+Managable defines which actions are availabled under a status.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/07/2017
extension InfiniteListStatus {
    
    /// System errors.
    private static let registrationAvailabilityError = "Register components without initial status."
    
    /// System warnings.
    private static let selectionAvailabilityWarning = "The status doesn't allow selecting an item."
    private static let reloadingAvailabilityWarning = "The status doesn't allow reloading items."
    private static let loadingMoreAvailabilityWarning = "The status doesn't allow loading more items."
    private static let editionAvailabilityWarning = "The status doesn't allow editing an item."
    private static let reloadingStatusWarning = "Reload items without reloading status."
    private static let loadingMoreStatusWarning = "Load more items without loading more status."
    
    /// Whether the reloading status has been settled or not.
    var isReloading: Bool {
        switch self {
        case .initial, .reloading:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadingStatusWarning)
            return false
        }
    }
    
    /// Whether the loading more status has been settled or not.
    var isLoadingMore: Bool {
        switch self {
        case .loadingMore:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadingMoreStatusWarning)
            return false
        }
    }
    
    /// Whether the reloading status can be settled or not.
    var isReloadingAvailable: Bool {
        switch self {
        case .infinite, .finite, .empty:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadingAvailabilityWarning)
            return false
        }
    }
    
    /// Whether the loading more status can be settled or not.
    var isLoadingMoreAvailable: Bool {
        switch self {
        case .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadingMoreAvailabilityWarning)
            return false
        }
    }
    
    /// Whether the selection can be performed or not.
    var isSelectingAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.selectionAvailabilityWarning)
            return false
        }
    }
    
    /// Whether the edition can be performed or not.
    var isEditionAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.editionAvailabilityWarning)
            return false
        }
    }
    
    /// Whether the registration can be performed or not.
    var isRegistrationAvailable: Bool {
        switch self {
        case .initial:
            return true
        default:
            Logger.standard.logError(InfiniteListStatus.registrationAvailabilityError)
            return false
        }
    }
    
    /// Whether the loading more bar should be hidden or not.
    var isLoadingMoreBarHidden: Bool {
        switch self {
        case .finite, .empty, .reloading, .initial:
            return true
        default:
            return false
        }
    }
    
}
