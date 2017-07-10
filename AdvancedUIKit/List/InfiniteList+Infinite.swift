/// InfiniteList+Infinite defines all things related to loading infinite items
/// - author: Adamas
/// - version: 1.0.0
/// - date: 04/07/2017
public extension InfiniteList {
    
    /// System errors.
    private static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    private static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    private static let loadingMoreBarNibError = "The nib file doesn't contain a UIView for the loading more bar."
    
    /// The height of the reloading bar.
    var reloadingBarHeight: CGFloat {
        return reloadingBar?.frame.height ?? 0
    }
    
    /// The height of the loading more bar.
    var loadingMoreBarHeight: CGFloat {
        return loadingMoreBar?.frame.height ?? 0
    }
    
    /// Register the load more view for the InfiniteList.
    /// - parameter nib: The nib file containing the view.
    public func registerLoadingMoreBar(with nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.loadingMoreBarNibError)
            return
        }
        view.frame = .init(x: 0, y: 0, width: frame.width, height: view.frame.height)
        view.isHidden = true
        loadingMoreBar = view
    }
    
    /// Register the reload view for the InfiniteList.
    /// - parameter nib: The nib file containing the view.
    public func registerReloadingBar(with nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.reloadingBarNibError)
            return
        }
        view.frame = .init(x: 0, y: -view.frame.height, width: frame.width, height: view.frame.height)
        reloadingBar = view
    }
    
    /// Perform drag and reload function programmatically.
    public func startReloading() {
        guard status.isReloadingAvailable else {
            return
        }
        status = .reloading
    }
    
}

import UIKit
