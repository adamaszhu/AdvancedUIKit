/// InfiniteList+ScrollViewDelegate implements the scroll view delegate of UITableView
/// - author: Adamas
/// - version: 1.0.0
/// - date: 03/07/2017
extension InfiniteList: UIScrollViewDelegate {
    
    /// The y offset for reloading status.
    var reloadingOffsetY: CGFloat {
        return -reloadingBarHeight
    }
    
    /// The y offset for loading more status.
    var loadingMoreOffsetY: CGFloat {
        return max(contentSize.height + loadingMoreBarHeight - frame.height, 0)
    }
    
    /// The y offset for displaying the last item.
    var bottomOffsetY: CGFloat {
        return max(contentSize.height - frame.height, 0)
    }
    
    /// UIScrollViewDelegate
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        infiniteListDelegate?.infiniteListDidScroll(self)
    }
    
    /// UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch status {
        case .reloading, .initial:
            contentOffset = .init(x: 0, y: reloadingOffsetY)
            return
        case .loadingMore:
            contentOffset = .init(x: 0, y: loadingMoreOffsetY)
            return
        case .finite, .empty:
            if contentOffset.y >= bottomOffsetY {
                contentOffset = .init(x: 0, y: bottomOffsetY)
            }
        case .infinite:
            if contentOffset.y >= loadingMoreOffsetY {
                contentOffset = .init(x: 0, y: loadingMoreOffsetY)
            }
        }
        if contentOffset.y <= reloadingOffsetY {
            contentOffset = .init(x: 0, y: reloadingOffsetY)
        }
    }
    
    /// UIScrollViewDelegate
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if contentOffset.y == loadingMoreOffsetY, let _ = loadingMoreBar, status.isLoadingMoreAvailable {
            status = .loadingMore
            infiniteListDelegate?.infiniteList(self, didRequireLoadPage: pageAmount)
            return
        }
        if contentOffset.y == reloadingOffsetY, let _ = reloadingBar, status.isReloadingAvailable {
            status = .reloading
            infiniteListDelegate?.infiniteListDidRequireReload(self)
        }
    }
    
}

import UIKit
