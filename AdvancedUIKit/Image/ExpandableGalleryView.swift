/// ExpandableGalleryView is a horizontal sliding image page view, which has full screen mode. If the navigation bar is translucent, GalleryView should be put inside a ScrollView.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 17/08/2019
final public class ExpandableGalleryView: GalleryView {
    
    /// The gesture filter to expand the view.
    private let gestureFilterView: UIView
    
    /// The gesture used to collapse the view.
    private let collapseGestureRecognizer: UITapGestureRecognizer
    
    public required init?(coder aDecoder: NSCoder) {
        gestureFilterView = UIView()
        collapseGestureRecognizer = UITapGestureRecognizer()
        super.init(coder: aDecoder)
        collapseGestureRecognizer.addTarget(self, action: #selector(collapse))
        gestureFilterView.frame = frame
        gestureFilterView.backgroundColor = UIColor.clear
        let expandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        gestureFilterView.addGestureRecognizer(expandGestureRecognizer)
        let showPreviousImageGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(switchToPreviousPage))
        showPreviousImageGestureRecognizer.direction = .right
        gestureFilterView.addGestureRecognizer(showPreviousImageGestureRecognizer)
        let showNextImageGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(switchToNextPage))
        showNextImageGestureRecognizer.direction = .left
        gestureFilterView.addGestureRecognizer(showNextImageGestureRecognizer)
    }
    
    public override func add(_ image: UIImage) {
        super.add(image)
        guard let galleryImage = subviews.last as? GalleryImage else {
            Logger.standard.logError(Self.subviewTypeError)
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
    
    var originalSuperview: UIView!
    var originalZIndex: Int!
    var originalFrame: CGRect!
    var originalFrameConstraints: [NSLayoutConstraint]!
    var originalConstraints: [NSLayoutConstraint]!
    
    public var isExpandable: Bool {
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
    
    /// Expand the frame with animation
    private func expandFrame() {
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        let pageControlBottomMargin = self.pageControlButtomMargin
        animateChange({ [weak self] in
            self?.frame = window.bounds
            self?.imageSize = window.bounds.size
            }, preparation: { [weak self] in
                guard let self = self else {
                    return
                }
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.pageControl.isHidden = true
        }) { [weak self] in
            self?.collapseGestureRecognizer.isEnabled = true
            self?.pageControlButtomMargin = pageControlBottomMargin
            self?.pageControl.isHidden = false
            self?.addBackground()
        }
    }
    
    /// Add background color with animation.
    private func addBackground() {
        animateChange( { [weak self] in
            self?.currentGalleryImage?.imageView.backgroundColor = .black
        }, completion:  { [weak self] in
            self?.setBackgroundColor(.black)
        })
    }
    
    /// Collapse the frame with animation
    private func collapseFrame() {
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        let pageControlBottomMargin = self.pageControlButtomMargin
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.imageSize = self.originalFrame.size
            }, preparation: { [weak self] in
                self?.collapseGestureRecognizer.isEnabled = false
                self?.pageControl.isHidden = true
        }) { [weak self] in
            guard let self = self else {
                return
            }
            self.removeFromWindow(of: self)
            self.gestureFilterView.isHidden = false
            self.pageControlButtomMargin = pageControlBottomMargin
            self.pageControl.isHidden = false
        }
    }
    
    /// Remove the background color with animation.
    private func removeBackgroundColor() {
        animateChange({ [weak self] in
            self?.currentGalleryImage?.imageView.backgroundColor = .clear
        }, completion:  { [weak self] in
            self?.setBackgroundColor(.clear)
            self?.collapseFrame()
        })
    }
    
    /// Set the background color of all subvies.
    ///
    /// - Parameter color: The color to be settled.
    private func setBackgroundColor(_ color: UIColor) {
        let subviews = self.subviews.compactMap {
            $0 as? GalleryImage
        }
        subviews.forEach {
            $0.imageView.backgroundColor = color
        }
    }
}

/// Expandable
extension ExpandableGalleryView: ExpandableView {
    
    public var isExpanded: Bool {
        guard let _ = superview else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return false
        }
        return superview == window
    }
    
    @objc public func expand() {
        guard !isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableGalleryView.expandingWarning)
            return
        }
        expandFrame()
    }
    
    @objc public func collapse() {
        guard isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableGalleryView.collapsingWarning)
            return
        }
        removeBackgroundColor()
    }
}

import AdvancedFoundation
import UIKit
