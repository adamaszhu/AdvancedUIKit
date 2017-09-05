/// GalleryView is used to display a list of images.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 11/06/2017
public class GalleryView: PageView {
    
    /// System error.
    static let subviewTypeError = "A subview is not a GalleryImage."
    
    /// The maximal zoom level of an image.
    private static let defaultMaxZoomLevel = CGFloat(8)
    
    /// The image content mode.
    private static let defaultImageMode = UIViewContentMode.scaleAspectFit
    
    /// The mode of the images displayed.
    public var imageMode: UIViewContentMode
    
    /// The max zoom level.
    public var maxZoomLevel: CGFloat
    
    /// The images presented.
    public var images: Array<UIImage> {
        set {
            removeAllViews()
            for image in newValue {
                add(image: image)
            }
        }
        get {
            return subviews.flatMap { subview in
                let galleryImage = subview as? GalleryImage
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
                if let galleryImage = subviews[index] as? GalleryImage {
                    galleryImage.frame.origin = CGPoint(x: CGFloat(index) * newValue.width, y: 0)
                    galleryImage.size = newValue
                } else {
                    Logger.standard.logError(GalleryView.subviewTypeError)
                }
            }
            setContentOffset(CGPoint(x: CGFloat(currentPageIndex) * newValue.width, y: 0), animated: false)
            contentSize = CGSize(width: CGFloat(pageControl.numberOfPages) * newValue.width, height: newValue.height)
        }
        get {
            return frame.size
        }
    }
    
    /// Add an image to the view.
    ///
    /// - Parameter image: The image to be added.
    public func add(image: UIImage) {
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
    
    /// Show previous image
    public func showPreviousImage() {
        switchToPreviousPage()
    }
    
    /// Show next image
    public func showNextImage() {
        switchToNextPage()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        imageMode = GalleryView.defaultImageMode
        maxZoomLevel = GalleryView.defaultMaxZoomLevel
        super.init(coder: aDecoder)
    }
    
}

import UIKit
