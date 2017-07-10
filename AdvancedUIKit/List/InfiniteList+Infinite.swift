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
        guard status.isRegisteringAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.loadMoreBarError)
            return
        }
        view.frame = .init(x: 0, y: 0, width: frame.width, height: view.frame.height)
        view.isHidden = true
        loadMoreBar = view
    }
    
    /**
     * Register the reload view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerReloadBar(_ nib: UINib) {
        guard status.isRegisteringAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.reloadBarError)
            return
        }
        view.frame = .init(x: 0, y: -view.frame.height, width: frame.width, height: view.frame.height)
        reloadBar = view
    }
    
    /**
          * The list should go into reload mode.
          */
    public func startReloading() {
        guard status.isReloadingAvailable else {
            return
        }
        status = .reloading
    }
    
}

import UIKit
