/**
 * InfiniteList+Infinite defines all things related to loading infinite items
 * - author: Adamas
 * - version: 1.0.0
 * - date: 04/07/2017
 */
public extension InfiniteList {
    
    /**
     * Register the load more view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerLoadMoreBar(_ nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registerStatusError)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.loadMoreBarError)
            return
        }
        view.frame = .init(x: 0, y: 0, width: frame.width, height: view.frame.height)
        insertSubview(view, at: 0)
        view.isHidden = true
        loadMoreBar = view
    }
    
    /**
     * Register the reload view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerReloadBar(_ nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registerStatusError)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.reloadBarError)
            return
        }
        reloadBar?.removeFromSuperview()
        view.frame = .init(x: 0, y: -view.frame.height, width: frame.width, height: view.frame.height)
        insertSubview(view, at: 0)
        // COMMENT: Adjust the scroll offset.
        scrollViewDidScroll(self)
        reloadBar = view
    }
    
}

import UIKit
