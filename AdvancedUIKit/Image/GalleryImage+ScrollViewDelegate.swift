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
        
        
        //        let scrollX = galleryImage.contentOffset.x
        //        let scrollY = galleryImage.contentOffset.y
        //        let imageViewFrame = galleryImage.imageView == nil ? CGRect(x: 0,y: 0,width: 0,height: 0) : galleryImage.imageView!.frame
        //        let imageFrame = galleryImage.imageView == nil ? CGRect(x: 0,y: 0,width: 0,height: 0) : galleryImage.imageView!.realFrame
        //        let imageMinX = imageFrame.origin.x
        //        let imageMaxX = imageFrame.origin.x + imageFrame.size.width
        //        let imageMinY = imageFrame.origin.y
        //        let imageMaxY = imageFrame.origin.y + imageFrame.size.height
        //        // COMMENT: Maintain the image in the view.
        //        let isBeyondWidth = imageMaxX - imageMinX > frame.size.width
        //        let isBeyondHeight = imageMaxY - imageMinY > frame.size.height
        //        let isBeyondLeft = scrollX < imageMinX
        //        let isBeyondRight = scrollX + frame.size.width > imageMaxX
        //        let isBeyondTop = scrollY < imageMinY
        //        let isBeyondBottom = scrollY + frame.size.height > imageMaxY
        //        var adjustedX = scrollX
        //        var adjustedY = scrollY
        //        if isBeyondWidth && isBeyondLeft {
        //            adjustedX = imageMinX
        //        }
        //        if isBeyondWidth && isBeyondRight {
        //            adjustedX = imageMaxX - frame.size.width
        //        }
        //        if !isBeyondWidth {
        //            adjustedX = imageViewFrame.size.width / 2 - frame.size.width / 2
        //        }
        //        if isBeyondHeight && isBeyondTop {
        //            adjustedY = imageMinY
        //        }
        //        if isBeyondHeight && isBeyondBottom {
        //            adjustedY = imageMaxY - frame.size.height
        //        }
        //        if !isBeyondHeight {
        //            adjustedY = imageViewFrame.size.height / 2 - frame.size.height / 2
        //        }
        //        horizontalSwipeOffset = horizontalSwipeOffset + adjustedX - scrollX
        //        scrollView.setContentOffset(CGPoint(x: adjustedX, y: adjustedY), animated: false)
        //        return
        
        
//        guard (contentSize.width >= frame.width) && (contentSize.height >= frame.height) else {
//            setZoomScale(1, animated: false)
//            return
//        }
//        var adjustOffset = contentOffset
//        adjustOffset.x = max(adjustOffset.x, 0)
//        adjustOffset.y = max(adjustOffset.y, 0)
//        adjustOffset.x = min(adjustOffset.x, contentSize.width - frame.width)
//        adjustOffset.y = min(adjustOffset.y, contentSize.height - frame.height)
//        guard adjustOffset != contentOffset else {
//            return
//        }
//        setContentOffset(adjustOffset, animated: false)
    }
    
}

import UIKit
