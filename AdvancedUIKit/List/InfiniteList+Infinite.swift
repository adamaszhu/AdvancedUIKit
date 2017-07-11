/// InfiniteList+Infinite defines all things related to loading infinite items
/// - author: Adamas
/// - version: 1.0.0
/// - date: 04/07/2017
public extension InfiniteList {
    
    /// System errors.
    private static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    private static let loadingMoreBarNibError = "The nib file doesn't contain a UIView for the loading more bar."
    private static let reloadingBarRegistrationError = "The reloading bar hasn't been registered yet."
    private static let displayStatusError = "The items cannot be displayed under current status."
    
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
        guard let _ = reloadingBar else {
            Logger.standard.logError(InfiniteList.reloadingBarRegistrationError)
            return
        }
        guard status.isReloadingAvailable else {
            return
        }
        animate(withChange: {
            self.contentOffset = .init(x: 0, y: self.reloadingOffsetY)
        }, withCompletion: {
            self.status = .reloading
            self.infiniteListDelegate?.infiniteListDidRequireReload(self)
        })
    }
    
    /// Display a list of item depending on the status of the InfiniteList.
    /// - parameter items: The item to be displayed.
    public func display(_ items: [InfiniteItem]) {
        switch status {
        case .initial, .reloading:
            reload(items)
        case .loadingMore:
            append(items)
        default:
            Logger.standard.logError(InfiniteList.displayStatusError)
        }
        // COMMENT: Adjust the content offset.
        if contentOffset.y < 0 {
            setContentOffset(.init(x: 0, y: 0), animated: true)
        }
    }
    
    /// Add the reloading bar to the window.
    func addReloadingBar() {
        guard let reloadingBar = reloadingBar, reloadingBar.superview == nil else {
            return
        }
        addSubview(reloadingBar)
        let height = reloadingBar.frame.height
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            // COMMENT: Wait for the subview to be resized.
            reloadingBar.frame.size = .init(width: reloadingBar.frame.width, height: height)
            // COMMENT: Adjust the scroll offset for the init status.
            self.contentOffset = .init(x: 0, y: -height)
            self.infiniteListDelegate?.infiniteListDidRequireReload(self)
        })
    }
    
    /// Add the loading more bar to the window.
    func addLoadingMoreBar() {
        guard let loadingMoreBar = loadingMoreBar, loadingMoreBar.superview == nil else {
            return
        }
        addSubview(loadingMoreBar)
        let height = loadingMoreBar.frame.height
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            // COMMENT: Wait for the subview to be resized.
            loadingMoreBar.frame.size = .init(width: loadingMoreBar.frame.width, height: height)
            // COMMENT: Hide the loading more bar for the init status.
            loadingMoreBar.isHidden = true
        })
    }
    
    /// Reload a list of items.
    /// - parameter items: The items to be reloaded.
    func reload(_ items: [InfiniteItem]) {
        guard status.isReloading else {
            return
        }
        self.items = items
        pageAmount = 1
        reloadData()
        expandedCellIndexPath = nil
        switch items.count {
        case 0:
            status = .empty
            showEmptyState()
        case 1 ..< pageSize:
            status = .finite
            hideEmptyState()
        default:
            status = .infinite
            hideEmptyState()
        }
    }
    
    /// Append a list of items.
    /// - parameter items: The items to be append.
    func append(_ items: [InfiniteItem]) {
        guard status.isLoadingMore else {
            return
        }
        self.items = self.items + items
        pageAmount = pageAmount + 1
        reloadData()
        switch items.count {
        case 0 ..< pageSize:
            status = .finite
        default:
            status = .infinite
        }
    }
    
}

import UIKit
