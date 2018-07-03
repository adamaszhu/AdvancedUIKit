/// PageView+ScrollViewDelegate detected the action when the page is switched.
///
/// - author: Adamas
/// - version: 1.3.0
/// - date: 02/07/2018
extension PageView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(contentOffset.x / frame.width))
        if pageIndex != currentPageIndex {
            pageControl.currentPage = pageIndex
            pageViewDelegate?.pageView(self, didChangeCurrentIndex: pageIndex)
        }
    }
    
}

import Foundation
import UIKit
