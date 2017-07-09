/**
 * InfiniteList+ScrollViewDelegate implements the scroll view delegate of UITableView
 * - author: Adamas
 * - version: 1.0.0
 * - date: 03/07/2017
 */
extension InfiniteList: UIScrollViewDelegate {
    
    /**
     * UIScrollViewDelegate
     */
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        infiniteListDelegate?.infiniteListDidScroll(self)
    }
    
    /**
     * UIScrollViewDelegate
     */
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let reloadBarHeight = reloadBar?.frame.height ?? 0
        let loadMoreBarHeight = loadMoreBar?.frame.height ?? 0
        let reloadOffsetY = -reloadBarHeight
        let loadMoreOffsetY = max(contentSize.height + loadMoreBarHeight - frame.height, 0)
        let bottomOffsetY = max(contentSize.height - frame.height, 0)
        switch status {
        case .reloading, .initial:
            contentOffset = .init(x: 0, y: reloadOffsetY)
            return
        case .loadingMore:
            contentOffset = .init(x: 0, y: loadMoreOffsetY)
            return
        case .finite, .empty:
            if contentOffset.y >= bottomOffsetY {
                contentOffset = .init(x: 0, y: bottomOffsetY)
            }
        case .infinite:
            if contentOffset.y >= loadMoreOffsetY {
                contentOffset = .init(x: 0, y: loadMoreOffsetY)
            }
        }
        if contentOffset.y <= reloadOffsetY {
            contentOffset = .init(x: 0, y: reloadOffsetY)
        }
    }
    
    /**
     * UIScrollViewDelegate
     */
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let reloadBarHeight = reloadBar?.frame.height ?? 0
        let loadMoreBarHeight = loadMoreBar?.frame.height ?? 0
        let reloadOffsetY = -reloadBarHeight
        let loadMoreOffsetY = max(contentSize.height + loadMoreBarHeight - frame.height, 0)
        switch status {
        case .infinite:
            if contentOffset.y == loadMoreOffsetY, loadMoreBar != nil {
                status = .loadingMore
                infiniteListDelegate?.infiniteList(self, didRequireLoadPage: pageAmount)
            }
        case .finite, .empty:
            break
        default:
            return
        }
        if contentOffset.y == reloadOffsetY, reloadBar != nil {
            status = .reloading
            infiniteListDelegate?.infiniteListDidRequireReload(self)
        }
    }
    
}

import UIKit
