/**
 * ExpandableGalleryView is a horizontal sliding image page view, which has full screen mode.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 17/06/2017
 */
public class ExpandableGalleryView: GalleryView {
//
//    /**
//     * The default image.
//     */
//    public var defaultImage: UIImage
//    
//    /**
//     * The full screen gallery.
//     */
//    private var fullScreenGalleryView: GalleryView
//    
//    /**
//     * Whether the view is existing the full screen mode or not.
//     */
//    private var isExistingFullScreen: Bool
//    
//    /**
// * Whether the view has been initialized or not.
// */
//    private var isInitialized: Bool
//    
//    /**
//     * Perform the entering animation.
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func performFullScreenAnimation() {
//        // COMMENT: The animation.
//        let animationBackground = UIView()
//        animationBackground.backgroundColor = UIColor.blackColor()
//        animationBackground.frame = window!.frame
//        window!.addSubview(animationBackground)
//        let animationImageView = UIImageView()
//        animationImageView.image = currentImageView?.image
//        window!.addSubview(animationImageView)
//        if (fullScreenGalleryView.currentImageView == nil) || (currentImageView == nil) {
//            // COMMENT: The error has already been logged.
//            return
//        }
//        window!.addSubview(fullScreenGalleryView)
//        let fullScreenGalleryImageFrame = fullScreenGalleryView.currentImageView!.convertRect(fullScreenGalleryView.currentImageView!.realFrame, toView: window)
//        let galleryImageViewFrame = currentImageView!.convertRect(currentImageView!.realFrame, toView: window)
//        // TODO: Judge whether there has been an animation operating or not.
//        UIView.animate(withChange: {
//            animationImageView.frame = fullScreenGalleryImageFrame
//            animationBackground.alpha = 1
//            }, withPreparationHandle: {
//                self.fullScreenGalleryView.alpha = 0
//                animationBackground.alpha = 0
//                animationImageView.frame = galleryImageViewFrame
//            }, withCompletionHandle: {
//                animationImageView.removeFromSuperview()
//                animationBackground.removeFromSuperview()
//                self.fullScreenGalleryView.alpha = 1
//        })
//    }
//    
//    /**
//     * Perform the exiting animation.
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    private func performExitFullScreenAnimation() {
//        // COMMENT: The animation.
//        let animationBackground = UIView()
//        animationBackground.backgroundColor = UIColor.blackColor()
//        animationBackground.frame = window!.frame
//        window!.addSubview(animationBackground)
//        let animationImageView = UIImageView()
//        animationImageView.image = currentImageView?.image
//        window!.addSubview(animationImageView)
//        if (fullScreenGalleryView.currentImageView == nil) || (currentImageView == nil) {
//            // COMMENT: The error has already been logged.
//            return
//        }
//        let fullScreenGalleryImageFrame = fullScreenGalleryView.currentImageView!.convertRect(fullScreenGalleryView.currentImageView!.realFrame, toView: window)
//        let galleryImageViewFrame = currentImageView!.convertRect(currentImageView!.realFrame, toView: window)
//        // TODO: This should just be hide.
//        fullScreenGalleryView.removeFromSuperview()
//        // TODO: Judge whether there has been an animation operating or not.
//        UIView.animate(withChange: {
//            animationImageView.frame = galleryImageViewFrame
//            animationBackground.alpha = 0
//            }, withPreparationHandle: {
//                animationBackground.alpha = 1
//                animationImageView.frame = fullScreenGalleryImageFrame
//            }, withCompletionHandle: {
//                animationImageView.removeFromSuperview()
//                animationBackground.removeFromSuperview()
//        })
//    }
//    
//    /**
//     * Enter full screen mode.
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func enterFullScreen() {
//        fullScreenGalleryView.switchToPage(currentPageIndex, withAnimation: false)
//        performFullScreenAnimation()
//    }
//    
//    /**
//     * Exit full screen mode.
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func exitFullScreen() {
//        isExistingFullScreen = true
//        fullScreenGalleryView.resetZoomScale(withAnimation: true)
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public required init?(coder aDecoder: NSCoder) {
//        fullScreenGalleryView = GalleryView(coder: aDecoder)!
//        defaultImage = UIImage()
//        isExistingFullScreen = false
//        isInitialized = false
//        super.init(coder: aDecoder)
//        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(enterFullScreen))
//        addGestureRecognizer(tapGesture)
//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(exitFullScreen))
//        fullScreenGalleryView.addGestureRecognizer(tapGesture)
//        fullScreenGalleryView.galleryViewDelegate = self
//        fullScreenGalleryView.backgroundColor = UIColor.blackColor()
//        fullScreenGalleryView.imageContentMode = UIViewContentMode.ScaleAspectFit
//        fullScreenGalleryView.shouldExpand = true
//        imageContentMode = UIViewContentMode.ScaleAspectFill
//        shouldExpand = false
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        if isInitialized {
//            return
//        }
//        isInitialized = true
//        fullScreenGalleryView.frame = window!.bounds
//        addImage(defaultImage)
//        fullScreenGalleryView.addImage(defaultImage)
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func setImageList(imageList: Array<UIImage>) {
//        super.setImageList(imageList)
//        fullScreenGalleryView.setImageList(imageList)
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public override func refreshImage(image: UIImage, atIndex index: NSInteger) {
//        super.refreshImage(image, atIndex: index)
//        fullScreenGalleryView.refreshImage(image, atIndex: index)
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public func galleryViewDidShowNextPage(galleryView: GalleryView) {
//        super.showNextPage()
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public func galleryViewDidShowPreviousPage(galleryView: GalleryView) {
//        super.showPreviousPage()
//    }
//    
//    /**
//     * - version: 0.1.2
//     * - date: 23/10/2016
//     */
//    public func galleryViewDidResetZoomLevel(galleryView: GalleryView) {
//        if isExistingFullScreen {
//            isExistingFullScreen = false
//            performExitFullScreenAnimation()
//        }
//    }
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
     * System error.
     */
    private static let superviewError = "The superview is nil."
    private static let windowError = "The window is nil."

    /**
     * System warning.
     */
    private static let expandWarning = "The view cannot be expanded."
    private static let collapseWarning = "The view cannot be collapsed."

    /**
     * The gesture filter to expand the view.
     */
    private let gestureFilterView: UIView

    /**
     * The gesture used to collapse the view.
     */
    private let collapseGestureRecognizer: UITapGestureRecognizer

    /**
     * The original superview.
     */
    private var originalSuperview: UIView!
    
    /**
     * The original z Index.
     */
    private var originalZIndex: Int!
    
    /**
     * The origin frame in origin view.
     */
    private var originalFrame: CGRect!
    
    /**
     * The original frame related constraints on the superview.
     */
    private var originalFrameConstraints: Array<NSLayoutConstraint>!
    
    /**
     * The original constraints.
     */
    private var originalConstraints: Array<NSLayoutConstraint>!

        /**
     * Whether the view can be expanded or not.
     */
    public var isExpandable: Bool {
        set {
            if newValue {
                guard let superview = superview else {
                    Logger.standard.logError(ExpandableGalleryView.superviewError)
                    return
                }
                superview.addSubview(gestureFilterView)
                addGestureRecognizer(collapseGestureRecognizer)
                collapseGestureRecognizer.isEnabled = false
            } else {
                gestureFilterView.removeFromSuperview()
                removeGestureRecognizer(collapseGestureRecognizer)
            }
        }
        get {
            return gestureRecognizers?.contains(collapseGestureRecognizer) == true
        }
    }

    /**
     * Whether the view is expanded or not.
     */
    public var isExpanded: Bool {
        guard superview != nil else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return false
        }
        return superview == window
    }

    /**
     * Expand the view.
     */
    public func expand() {
        guard !isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableGalleryView.expandWarning)
            return
        }
        guard let superview = superview else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        originalSuperview = superview
        originalZIndex = superview.subviews.index(of: self)
        originalFrame = frame
        originalFrameConstraints = frameConstraints
        // TODO: Exclude those constraints related to subviews.
        originalConstraints = constraints
        animate(withChange: { [unowned self] _ in
            self.frame = window.bounds
            self.imageSize = window.bounds.size
            self.backgroundColor = .black
            }, withPreparation: { [unowned self] _ in
                self.gestureFilterView.isHidden = true
                self.moveToWindow()
            }, withCompletion: { [unowned self] _ in
                self.collapseGestureRecognizer.isEnabled = true
        })
    }

    /**
     * Collapse the view.
     */
    public func collapse() {
        guard isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableGalleryView.collapseWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.imageSize = self.originalFrame.size
            self.backgroundColor = .clear
            }, withPreparation: { [unowned self] _ in
                self.collapseGestureRecognizer.isEnabled = false
            }, withCompletion: { [unowned self] _ in
                self.removeFromWindow()
                self.gestureFilterView.isHidden = false
        })
    }

    /**
     * Wait until the view has been added back to the original superview and add constraints.
     */
    func addOriginalConstraints() {
        guard let superview = superview else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return
        }
        superview.addConstraints(originalFrameConstraints)
        addConstraints(originalConstraints)
    }

    /**
     * Move current view to the window.
     */
    private func moveToWindow() {
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        guard let superview = superview else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return
        }
        superview.removeConstraints(originalFrameConstraints)
        removeConstraints(originalConstraints)
        removeFromSuperview()
        window.addSubview(self)
        frame = window.convert(originalFrame, from: originalSuperview)
        translatesAutoresizingMaskIntoConstraints = true
    }

    /**
     * Remove the view from window and move it back to its original superview.
     */
    private func removeFromWindow() {
        translatesAutoresizingMaskIntoConstraints = false
        removeFromSuperview()
        originalSuperview.insertSubview(self, at: originalZIndex)
        addOriginalConstraints()
        // COMMENT: Wait the view to be refreshed and add the constraint back
        perform(#selector(addOriginalConstraints), with: nil, afterDelay: 0.2)
    }

    /**
     * GalleryView
     */
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        collapseGestureRecognizer = UITapGestureRecognizer()
        super.init(coder: aDecoder)
        collapseGestureRecognizer.addTarget(self, action: #selector(collapse))
        gestureFilterView.frame = frame
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
        let showPreviousImageGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(showPreviousImage))
        showPreviousImageGestureRecognizer.direction = .right
        gestureFilterView.addGestureRecognizer(showPreviousImageGestureRecognizer)
        let showNextImageGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(showNextImage))
        showNextImageGestureRecognizer.direction = .left
        gestureFilterView.addGestureRecognizer(showNextImageGestureRecognizer)
    }

}

import UIKit
