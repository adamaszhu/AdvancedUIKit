/**
 * GalleryImage+ScrollViewDelegate implements the method related to zooming.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 15/06/2017
 */
extension GalleryImage: UIScrollViewDelegate {
    
    /**
     * UIScrollViewDelegate
     */
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /**
     * UIScrollViewDelegate
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (contentSize.width >= frame.width) && (contentSize.height >= frame.height) else {
            setZoomScale(1, animated: false)
            return
        }
        var adjustOffset = contentOffset
        adjustOffset.x = max(adjustOffset.x, 0)
        adjustOffset.y = max(adjustOffset.y, 0)
        adjustOffset.x = min(adjustOffset.x, contentSize.width - frame.width)
        adjustOffset.y = min(adjustOffset.y, contentSize.height - frame.height)
        guard adjustOffset != contentOffset else {
            return
        }
        setContentOffset(adjustOffset, animated: false)
    }
    
}

import UIKit
