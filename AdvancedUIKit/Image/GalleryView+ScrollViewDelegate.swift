/// GalleryView+ScrollViewDelegate override the paging switching.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 17/06/2017
extension GalleryView {
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var adjustedOffset = contentOffset
        adjustedOffset.x = max(adjustedOffset.x, 0)
        adjustedOffset.x = min(adjustedOffset.x, contentSize.width - frame.width)
        if adjustedOffset != contentOffset {
            setContentOffset(adjustedOffset, animated: false)
        }
        let pageIndex = Int(round(contentOffset.x / frame.width))
        guard pageIndex != currentPageIndex else {
            return
        }
        currentGalleryImage?.resetZoomLevel()
        currentPageIndex = pageIndex
    }
    
}

import UIKit
