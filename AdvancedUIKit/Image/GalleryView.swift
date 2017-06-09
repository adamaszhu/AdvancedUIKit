import UIKit

/**
 * GalleryView is used to display a list of images.
 * - author: Adamas
 * - version: 0.0.5
 * - date: 23/10/2016
 */
public class GalleryView: PageView, UIScrollViewDelegate {
    
    /**
     * System message.
     */
    private static let IndexError = "The index of the image is out of range."
    
    /**
     * The maximal zoom level of an image.
     */
    private static let MaxZoomLevel = CGFloat(8)
    
    /**
     * The delegate.
     */
    public var galleryViewDelegate: GalleryViewDelegate?
    
    /**
     * Whether the image can be zoomed in or not.
     */
    public var shouldExpand: Bool
    
    /**
     * The mode of the images displayed.
     */
    public var imageContentMode: UIViewContentMode
    
    /**
     * The image view that is currently displayed.
     */
    public var currentImageView: UIImageView? {
        /**
         * - version: 0.0.5
         * - date: 23/10/2016
         */
        get {
            if (currentPageIndex < 0) || (currentPageIndex >= galleryImageList.count) {
                logError(GalleryView.IndexError)
                return nil
            }
            return galleryImageList[currentPageIndex].imageView
        }
    }
    
    /**
     * The horizontal offset accumulator within a horizontal gesture period.
     */
    private var horizontalSwipeOffset: CGFloat
    
    /**
     * A list of image frame.
     */
    var galleryImageList: Array<GalleryImage>
    
    /**
     * Set the list of images displayed on the screen.
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public func setImageList(imageList: Array<UIImage>) {
        removeAllSubviews()
        galleryImageList.removeAll()
        for image in imageList {
            addImage(image)
        }
    }
    
    /**
     * Add an image to the view.
     * - version: 0.0.5
     * - date: 23/10/2016
     * - parameter image: The image to be added.
     */
    public func addImage(image: UIImage) {
        let galleryImage = GalleryImage()
        if shouldExpand {
            galleryImage.delegate = self
            galleryImage.maximumZoomScale = GalleryView.MaxZoomLevel
        } else {
            galleryImage.maximumZoomScale = 1
        }
        let imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        imageView.clipsToBounds = true
        imageView.contentMode = imageContentMode
        imageView.image = image
        galleryImage.addSubview(imageView)
        addView(galleryImage)
        galleryImageList.append(galleryImage)
    }
    
    /**
     * Refresh an image to the view.
     * - version: 0.0.5
     * - date: 23/10/2016
     * - parameter index: The index of the new image.
     * - parameter image: The image. Any object other than UIImage object will be replaced by a default image.
     */
    public func refreshImage(image: UIImage, atIndex index: NSInteger) {
        if (index < 0) || (index >= galleryImageList.count) {
            logError(GalleryView.IndexError)
            return
        }
        galleryImageList[index].imageView?.image = image
    }
    
    /**
     * Reset the zoom scale for all pages.
     * - version: 0.0.5
     * - date: 23/10/2016
     * - parameter animate: The animation should be performed or not.
     */
    public func resetZoomScale(withAnimation shouldAnimate: Bool) {
        if (currentPageIndex < 0) || (currentPageIndex >= galleryImageList.count) {
            logError(GalleryView.IndexError)
            return
        }
        let galleryImage = galleryImageList[currentPageIndex]
        if galleryImage.zoomScale == 1 {
            galleryViewDelegate?.galleryViewDidResetZoomLevel(self)
            return
        }
        if !shouldAnimate {
            galleryImage.zoomScale = 1
            galleryViewDelegate?.galleryViewDidResetZoomLevel(self)
            return
        }
        // TODO: Judge whether there has been an animation operating or not.
        UIView.animate(withChange: {
            galleryImage.zoomScale = 1
            }, withPreparationHandle: nil, withCompletionHandle: {
                self.galleryViewDelegate?.galleryViewDidResetZoomLevel(self)
        })
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public required init?(coder aDecoder: NSCoder) {
        shouldExpand = false
        imageContentMode = UIViewContentMode.ScaleAspectFit
        galleryImageList = []
        horizontalSwipeOffset = 0
        super.init(coder: aDecoder)
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public override init(frame: CGRect) {
        shouldExpand = false
        imageContentMode = UIViewContentMode.ScaleAspectFit
        galleryImageList = []
        horizontalSwipeOffset = 0
        super.init(frame: frame)
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public override func showPreviousPage() {
        super.showPreviousPage()
        resetZoomScale(withAnimation: false)
        galleryViewDelegate?.galleryViewDidShowPreviousPage(self)
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public override func showNextPage() {
        super.showNextPage()
        resetZoomScale(withAnimation: false)
        galleryViewDelegate?.galleryViewDidShowNextPage(self)
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        let galleryImage = scrollView as! GalleryImage
        return galleryImage.imageView
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let galleryImage = scrollView as! GalleryImage
        let scrollX = galleryImage.contentOffset.x
        let scrollY = galleryImage.contentOffset.y
        let imageViewFrame = galleryImage.imageView == nil ? CGRect(x: 0,y: 0,width: 0,height: 0) : galleryImage.imageView!.frame
        let imageFrame = galleryImage.imageView == nil ? CGRect(x: 0,y: 0,width: 0,height: 0) : galleryImage.imageView!.realFrame
        let imageMinX = imageFrame.origin.x
        let imageMaxX = imageFrame.origin.x + imageFrame.size.width
        let imageMinY = imageFrame.origin.y
        let imageMaxY = imageFrame.origin.y + imageFrame.size.height
        // COMMENT: Maintain the image in the view.
        let isBeyondWidth = imageMaxX - imageMinX > frame.size.width
        let isBeyondHeight = imageMaxY - imageMinY > frame.size.height
        let isBeyondLeft = scrollX < imageMinX
        let isBeyondRight = scrollX + frame.size.width > imageMaxX
        let isBeyondTop = scrollY < imageMinY
        let isBeyondBottom = scrollY + frame.size.height > imageMaxY
        var adjustedX = scrollX
        var adjustedY = scrollY
        if isBeyondWidth && isBeyondLeft {
            adjustedX = imageMinX
        }
        if isBeyondWidth && isBeyondRight {
            adjustedX = imageMaxX - frame.size.width
        }
        if !isBeyondWidth {
            adjustedX = imageViewFrame.size.width / 2 - frame.size.width / 2
        }
        if isBeyondHeight && isBeyondTop {
            adjustedY = imageMinY
        }
        if isBeyondHeight && isBeyondBottom {
            adjustedY = imageMaxY - frame.size.height
        }
        if !isBeyondHeight {
            adjustedY = imageViewFrame.size.height / 2 - frame.size.height / 2
        }
        horizontalSwipeOffset = horizontalSwipeOffset + adjustedX - scrollX
        scrollView.setContentOffset(CGPoint(x: adjustedX, y: adjustedY), animated: false)
        return
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // COMMENT: Show previous page and next page.
        if (horizontalSwipeOffset > frame.width / 3) && (currentPageIndex > 0) {
            showPreviousPage()
            return
        }
        if (horizontalSwipeOffset < -frame.size.width / 3) && (currentPageIndex < galleryImageList.count - 1) {
            showNextPage()
            return
        }
    }
    
    /**
     * - version: 0.0.5
     * - date: 23/10/2016
     */
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        horizontalSwipeOffset = 0
    }
}
