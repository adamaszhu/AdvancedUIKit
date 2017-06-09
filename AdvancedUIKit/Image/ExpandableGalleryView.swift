import UIKit

/**
 * ExpandableGalleryView is a horizontal sliding image page view, which has full screen mode.
 * - author: Adamas
 * - version: 0.1.2
 * - date: 23/10/2016
 */
public class ExpandableGalleryView : GalleryView, GalleryViewDelegate {
    
    /**
     * The default image.
     */
    public var defaultImage: UIImage
    
    /**
     * The full screen gallery.
     */
    private var fullScreenGalleryView: GalleryView
    
    /**
     * Whether the view is existing the full screen mode or not.
     */
    private var isExistingFullScreen: Bool
    
    /**
 * Whether the view has been initialized or not.
 */
    private var isInitialized: Bool
    
    /**
     * Perform the entering animation.
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func performFullScreenAnimation() {
        // COMMENT: The animation.
        let animationBackground = UIView()
        animationBackground.backgroundColor = UIColor.blackColor()
        animationBackground.frame = window!.frame
        window!.addSubview(animationBackground)
        let animationImageView = UIImageView()
        animationImageView.image = currentImageView?.image
        window!.addSubview(animationImageView)
        if (fullScreenGalleryView.currentImageView == nil) || (currentImageView == nil) {
            // COMMENT: The error has already been logged.
            return
        }
        window!.addSubview(fullScreenGalleryView)
        let fullScreenGalleryImageFrame = fullScreenGalleryView.currentImageView!.convertRect(fullScreenGalleryView.currentImageView!.realFrame, toView: window)
        let galleryImageViewFrame = currentImageView!.convertRect(currentImageView!.realFrame, toView: window)
        // TODO: Judge whether there has been an animation operating or not.
        UIView.animate(withChange: {
            animationImageView.frame = fullScreenGalleryImageFrame
            animationBackground.alpha = 1
            }, withPreparationHandle: {
                self.fullScreenGalleryView.alpha = 0
                animationBackground.alpha = 0
                animationImageView.frame = galleryImageViewFrame
            }, withCompletionHandle: {
                animationImageView.removeFromSuperview()
                animationBackground.removeFromSuperview()
                self.fullScreenGalleryView.alpha = 1
        })
    }
    
    /**
     * Perform the exiting animation.
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    private func performExitFullScreenAnimation() {
        // COMMENT: The animation.
        let animationBackground = UIView()
        animationBackground.backgroundColor = UIColor.blackColor()
        animationBackground.frame = window!.frame
        window!.addSubview(animationBackground)
        let animationImageView = UIImageView()
        animationImageView.image = currentImageView?.image
        window!.addSubview(animationImageView)
        if (fullScreenGalleryView.currentImageView == nil) || (currentImageView == nil) {
            // COMMENT: The error has already been logged.
            return
        }
        let fullScreenGalleryImageFrame = fullScreenGalleryView.currentImageView!.convertRect(fullScreenGalleryView.currentImageView!.realFrame, toView: window)
        let galleryImageViewFrame = currentImageView!.convertRect(currentImageView!.realFrame, toView: window)
        // TODO: This should just be hide.
        fullScreenGalleryView.removeFromSuperview()
        // TODO: Judge whether there has been an animation operating or not.
        UIView.animate(withChange: {
            animationImageView.frame = galleryImageViewFrame
            animationBackground.alpha = 0
            }, withPreparationHandle: {
                animationBackground.alpha = 1
                animationImageView.frame = fullScreenGalleryImageFrame
            }, withCompletionHandle: {
                animationImageView.removeFromSuperview()
                animationBackground.removeFromSuperview()
        })
    }
    
    /**
     * Enter full screen mode.
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func enterFullScreen() {
        fullScreenGalleryView.switchToPage(currentPageIndex, withAnimation: false)
        performFullScreenAnimation()
    }
    
    /**
     * Exit full screen mode.
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func exitFullScreen() {
        isExistingFullScreen = true
        fullScreenGalleryView.resetZoomScale(withAnimation: true)
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public required init?(coder aDecoder: NSCoder) {
        fullScreenGalleryView = GalleryView(coder: aDecoder)!
        defaultImage = UIImage()
        isExistingFullScreen = false
        isInitialized = false
        super.init(coder: aDecoder)
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(enterFullScreen))
        addGestureRecognizer(tapGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(exitFullScreen))
        fullScreenGalleryView.addGestureRecognizer(tapGesture)
        fullScreenGalleryView.galleryViewDelegate = self
        fullScreenGalleryView.backgroundColor = UIColor.blackColor()
        fullScreenGalleryView.imageContentMode = UIViewContentMode.ScaleAspectFit
        fullScreenGalleryView.shouldExpand = true
        imageContentMode = UIViewContentMode.ScaleAspectFill
        shouldExpand = false
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if isInitialized {
            return
        }
        isInitialized = true
        fullScreenGalleryView.frame = window!.bounds
        addImage(defaultImage)
        fullScreenGalleryView.addImage(defaultImage)
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func setImageList(imageList: Array<UIImage>) {
        super.setImageList(imageList)
        fullScreenGalleryView.setImageList(imageList)
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public override func refreshImage(image: UIImage, atIndex index: NSInteger) {
        super.refreshImage(image, atIndex: index)
        fullScreenGalleryView.refreshImage(image, atIndex: index)
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public func galleryViewDidShowNextPage(galleryView: GalleryView) {
        super.showNextPage()
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public func galleryViewDidShowPreviousPage(galleryView: GalleryView) {
        super.showPreviousPage()
    }
    
    /**
     * - version: 0.1.2
     * - date: 23/10/2016
     */
    public func galleryViewDidResetZoomLevel(galleryView: GalleryView) {
        if isExistingFullScreen {
            isExistingFullScreen = false
            performExitFullScreenAnimation()
        }
    }
    
}
