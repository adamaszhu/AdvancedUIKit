/// GalleryView is used to display a list of images. If the navigation bar is translucent, GalleryView should be put inside a ScrollView.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 11/06/2017
public class GalleryView: PageView {
    
    /// The mode of the images displayed.
    @objc public var imageMode: UIViewContentMode
    
    /// The max zoom level.
    @objc public var maxZoomLevel: CGFloat
    
    /// The images presented.
    @objc public var images: [UIImage] {
        set {
            removeAllViews()
            newValue.forEach {
                add(image: $0)
            }
        }
        get {
            return subviews.compactMap {
                let galleryImage = $0 as? GalleryImage
                return galleryImage?.image
            }
        }
    }
    
    /// The image presented.
    @objc public var currentImage: UIImage? {
        return currentGalleryImage?.image
    }
    
    /// The gallery image presented.
    @objc var currentGalleryImage: GalleryImage? {
        guard let galleryImage = currentPage as? GalleryImage else {
            Logger.standard.logError(GalleryView.subviewTypeError)
            return nil
        }
        return galleryImage
    }
    
    /// The size of the GalleryView
    @objc var imageSize: CGSize {
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
    @objc public func add(image: UIImage) {
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
    @objc public func refresh(_ image: UIImage, atIndex index: Int) {
        currentGalleryImage?.image = image
    }
    
    /// Show previous image
    @objc public func showPreviousImage() {
        switchToPreviousPage()
    }
    
    /// Show next image
    @objc public func showNextImage() {
        switchToNextPage()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        imageMode = GalleryView.defaultImageMode
        maxZoomLevel = GalleryView.defaultMaxZoomLevel
        super.init(coder: aDecoder)
    }
    
}

import AdvancedFoundation
import UIKit
