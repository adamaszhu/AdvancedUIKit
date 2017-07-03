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
    
}

import UIKit
