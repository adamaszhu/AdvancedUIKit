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
    
    /// Whether the reloading status can be settled or not.
    var isReloadingAvailable: Bool {
        switch self {
        case .infinite, .finite, .empty:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadingWarning)
            return false
        }
    }
    
    /// Whether the loading more status can be settled or not.
    var isLoadingMoreAvailable: Bool {
        switch self {
        case .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadingMoreWarning)
            return false
        }
    }
    
    /// Whether reloading items are available or not
    var isReloadingItemAvailable: Bool {
        switch self {
        case .reloading, .initial:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.reloadingStatusWarning)
            return false
        }
    }
    
    /// Whether appending items are available or not
    var isLoadingMoreItemAvailable: Bool {
        switch self {
        case .loadingMore:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.loadingMoreStatusWarning)
            return false
        }
    }
    
    /// Whether the selection can be performed or not.
    var isSelectingAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.selectionWarning)
            return false
        }
    }
    
    /// Whether the edition can be performed or not.
    var isEditingAvailable: Bool {
        switch self {
        case .finite, .infinite:
            return true
        default:
            Logger.standard.logWarning(InfiniteListStatus.editionWarning)
            return false
        }
    }
    
    /// Whether the registration can be performed or not.
    var isRegistrationAvailable: Bool {
        switch self {
        case .initial:
            return true
        default:
            Logger.standard.logError(InfiniteListStatus.registrationError)
            return false
        }
    }
    
    /// Whether the loading more bar should be hidden or not.
    var isLoadingMoreCellHidden: Bool {
        switch self {
        case .finite, .empty, .reloading, .initial:
            return true
        default:
            return false
        }
    }
}

/// Constants
private extension InfiniteListStatus {
    
    /// System errors.
    static let registrationError = "Register components without initial status."
    
    /// System warnings.
    static let selectionWarning = "The status doesn't allow selecting an item."
    static let reloadingWarning = "The status doesn't allow reloading items."
    static let loadingMoreWarning = "The status doesn't allow loading more items."
    static let editionWarning = "The status doesn't allow editing an item."
    static let reloadingStatusWarning = "Reload items without reloading status."
    static let loadingMoreStatusWarning = "Load more items without loading more status."
}

import AdvancedFoundation
