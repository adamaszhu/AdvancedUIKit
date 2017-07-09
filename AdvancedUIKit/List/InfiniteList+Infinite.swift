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
        view.frame = .init(x: 0, y: -view.frame.height, width: frame.width, height: view.frame.height)
        reloadBar = view
    }
    //
    //    /**
    //     * The list should go into reload mode.
    //     * - version: 0.0.9
    //     * - date: 23/10/2016
    //     */
    //    public func startReloading() {
    //        switch status {
    //        case .Initial, .Reloading:
    //            break
    //        case .LoadingMore, .Idle:
    //            // COMMENT: Display the loading cell.
    //            status = DynamicListStatus.Reloading
    //            reloadData()
    //            setContentOffset(CGPointMake(0, reloadCellHeight), animated: false)
    //            UIView.animate(withChange: {
    //                self.contentOffset = CGPointMake(0, 0)
    //            })
    //        }
    //    }
    //
    //    /**
    //     * Stop reloading status.
    //     * - version: 0.0.9
    //     * - date: 23/10/2016
    //     */
    //    private func stopReloading() {
    //        switch status {
    //        case .Idle, .LoadingMore:
    //            logError(DynamicList.StatusError)
    //        case .Initial, .Reloading:
    //            UIView.animate(withChange: { () -> Void in
    //                self.setContentOffset(CGPointMake(0, self.reloadCellHeight - 1), animated: false)
    //                }, withCompletionHandle: {
    //                    self.status = DynamicListStatus.Idle
    //                    self.reloadData()
    //                    self.contentOffset = CGPointMake(0, 0)
    //            })
    //        }
    //    }
    //    /**
    //     * Start the loading animation in a view.
    //     * - version: 0.0.9
    //     * - date: 23/10/2016
    //     * - parameter view: The view that the operation will be operated on.
    //     */
    //    private func startActivityIndicatorAnimation(inView view: UIView) {
    //        for subview in view.subviews {
    //            if subview.isKindOfClass(UIActivityIndicatorView) {
    //                (subview as! UIActivityIndicatorView).startAnimating()
    //            } else if subview.subviews.count != 0 {
    //                startActivityIndicatorAnimation(inView: subview)
    //            }
    //        }
    //    }
    
}

import UIKit
