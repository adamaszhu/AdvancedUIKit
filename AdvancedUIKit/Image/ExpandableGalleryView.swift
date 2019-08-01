/// ExpandableGalleryView is a horizontal sliding image page view, which has full screen mode. If the navigation bar is translucent, GalleryView should be put inside a ScrollView.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 17/06/2017
final public class ExpandableGalleryView: GalleryView {
    
    /// The gesture filter to expand the view.
    @objc let gestureFilterView: UIView
    
    /// The gesture used to collapse the view.
    @objc let collapseGestureRecognizer: UITapGestureRecognizer
    
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
    
    public override var images: [UIImage] {
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
    
    @objc var originalSuperview: UIView!
    var originalZIndex: Int!
    var originalFrame: CGRect!
    @objc var originalFrameConstraints: [NSLayoutConstraint]!
    @objc var originalConstraints: [NSLayoutConstraint]!
    
    @objc public var isExpandable: Bool {
        set {
            guard newValue else {
                gestureFilterView.removeFromSuperview()
                removeGestureRecognizer(collapseGestureRecognizer)
                return
            }
            guard let superview = superview else {
                Logger.standard.logError(ExpandableGalleryView.superviewError)
                return
            }
            superview.addSubview(gestureFilterView)
            addGestureRecognizer(collapseGestureRecognizer)
            collapseGestureRecognizer.isEnabled = false
            
        }
        get {
            return gestureRecognizers?.contains(collapseGestureRecognizer) == true
        }
    }
    
}

import AdvancedFoundation
import UIKit
