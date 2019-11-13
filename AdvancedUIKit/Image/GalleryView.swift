/// GalleryView is used to display a list of images. If the navigation bar is translucent, GalleryView should be put inside a ScrollView.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 18/08/2019
public class GalleryView: PageView {
    
    /// The mode of the images displayed.
    public var imageMode: UIView.ContentMode = GalleryView.defaultImageMode
    
    /// The max zoom level.
    public var maxZoomLevel: CGFloat = GalleryView.defaultMaxZoomLevel
    
    /// The images presented.
    public var images: [UIImage] {
        set {
            removeAllViews()
            newValue.forEach(add)
        }
        get {
            return subviews.compactMap {
                let galleryImage = $0 as? GalleryImage
                return galleryImage?.image
            }
        }
    }
    
    /// The image presented.
    public var currentImage: UIImage? {
        return currentGalleryImage?.image
    }
    
    /// The gallery image presented.
    var currentGalleryImage: GalleryImage? {
        guard let galleryImage = currentPage as? GalleryImage else {
            Logger.standard.logError(GalleryView.subviewTypeError)
            return nil
        }
        return galleryImage
    }
    
    /// The size of the GalleryView
    var imageSize: CGSize {
        set {
            for index in 0 ..< subviews.count {
                guard let galleryImage = subviews[index] as? GalleryImage else {
                    Logger.standard.logError(GalleryView.subviewTypeError)
                    return
                }
                galleryImage.frame.origin = CGPoint(x: CGFloat(index) * newValue.width, y: 0)
                galleryImage.size = newValue
            }
            setContentOffset(CGPoint(x: CGFloat(currentPageIndex) * newValue.width, y: 0), animated: false)
            contentSize = CGSize(width: CGFloat(numberOfPages) * newValue.width, height: newValue.height)
        }
        get {
            return frame.size
        }
    }
    
    /// Add an image to the view.
    ///
    /// - Parameter image: The image to be added.
    public func add(_ image: UIImage) {
        let galleryImage = GalleryImage()
        galleryImage.image = image
        galleryImage.maxZoomLevel = maxZoomLevel
        galleryImage.imageMode = imageMode
        add(galleryImage)
    }
    
    /// Refresh an image to the view.
    ///
    /// - Parameters:
    ///   - index: The index of the new image.
    ///   - image: The image. Any object other than UIImage object will be replaced by a default image.
    public func refresh(_ image: UIImage, atIndex index: Int) {
        currentGalleryImage?.image = image
    }
    
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
        pageControl.currentPage = pageIndex
    }
}

/// Constants
extension GalleryView {
    
    /// System error.
    static let subviewTypeError = "A subview is not a GalleryImage."
    
    /// The maximal zoom level of an image.
    static let defaultMaxZoomLevel = CGFloat(8)
    
    /// The image content mode.
    static let defaultImageMode = UIView.ContentMode.scaleAspectFit
}

import AdvancedFoundation
import UIKit
