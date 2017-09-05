/// ExpandableGalleryView is a horizontal sliding image page view, which has full screen mode.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 17/06/2017
public class ExpandableGalleryView: GalleryView {
    
    /// The gesture filter to expand the view.
    let gestureFilterView: UIView

    /// The gesture used to collapse the view.
    let collapseGestureRecognizer: UITapGestureRecognizer

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
    
    public override func add(image: UIImage) {
        super.add(image: image)
        guard let galleryImage = subviews.last as? GalleryImage else {
            Logger.standard.logError(ExpandableGalleryView.subviewTypeError)
            return
        }
        collapseGestureRecognizer.require(toFail: galleryImage.doubleTapGestureRecognizer)
    }
    
    public override var images: Array<UIImage> {
        set {
            super.images = newValue
            for subview in subviews {
            guard let galleryImage = subview as? GalleryImage else {
                Logger.standard.logError(ExpandableGalleryView.subviewTypeError)
                return
            }
            collapseGestureRecognizer.require(toFail: galleryImage.doubleTapGestureRecognizer)
            }
        }
        get {
            return super.images
        }
    }
    
    var originalSuperview: UIView!
    var originalZIndex: Int!
    var originalFrame: CGRect!
    var originalFrameConstraints: Array<NSLayoutConstraint>!
    var originalConstraints: Array<NSLayoutConstraint>!
    
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

}

import UIKit
