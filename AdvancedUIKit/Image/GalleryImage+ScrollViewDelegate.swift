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
    
}

import UIKit
