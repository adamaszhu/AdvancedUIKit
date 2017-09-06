/// ExpandableGalleryView+Expandable defines what an expandable gallery view should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 19/06/2017
extension ExpandableGalleryView: ExpandableView {
    
    /// Expand the frame with animation
    private func expandFrame() {
        guard let window = window else {
            Logger.standard.log(error: ExpandableGalleryView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        let pageControlBottomMargin = self.pageControlButtomMargin
        animate(withChange: { [unowned self] _ in
            self.frame = window.bounds
            self.imageSize = window.bounds.size
            }, withPreparation: { [unowned self] _ in
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.pageControl.isHidden = true
            }, withCompletion: { [unowned self] _ in
                self.collapseGestureRecognizer.isEnabled = true
                self.pageControlButtomMargin = pageControlBottomMargin
                self.pageControl.isHidden = false
                self.addBackground()
        })
    }
    
    /// Add background color with animation.
    private func addBackground() {
        animate(withChange: { [unowned self] _ in
            self.currentGalleryImage?.imageView.backgroundColor = .black
        }) { [unowned self] _ in
            self.setBackgroundColor(.black)
        }
    }
    
    /// Collapse the frame with animation
    private func collapseFrame() {
        guard let window = window else {
            Logger.standard.log(error: ExpandableGalleryView.windowError)
            return
        }
        let pageControlBottomMargin = self.pageControlButtomMargin
        animate(withChange: { [unowned self] _ in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.imageSize = self.originalFrame.size
            }, withPreparation: { [unowned self] _ in
                self.collapseGestureRecognizer.isEnabled = false
                self.pageControl.isHidden = true
            }, withCompletion: { [unowned self] _ in
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
                self.pageControlButtomMargin = pageControlBottomMargin
                self.pageControl.isHidden = false
        })
    }
    
    /// Remove the background color with animation.
    private func removeBackgroundColor() {
        animate(withChange: { [unowned self] _ in
            self.currentGalleryImage?.imageView.backgroundColor = .clear
        }) { [unowned self] _ in
            self.setBackgroundColor(.clear)
            self.collapseFrame()
        }
    }
    
    /// Set the background color of all subvies.
    ///
    /// - Parameter color: The color to be settled.
    private func setBackgroundColor(_ color: UIColor) {
        let subviews = self.subviews.map{ (subview) in
            subview as? GalleryImage
        }
        for view in subviews {
            view?.imageView.backgroundColor = color
        }
    }
    
    public var isExpanded: Bool {
        guard superview != nil else {
            Logger.standard.log(error: ExpandableGalleryView.superviewError)
            return false
        }
        return superview == window
    }
    
    public func expand() {
        guard !isExpanded && isExpandable else {
            Logger.standard.log(warning: ExpandableGalleryView.expandWarning)
            return
        }
        expandFrame()
    }
    
    public func collapse() {
        guard isExpanded && isExpandable else {
            Logger.standard.log(warning: ExpandableGalleryView.collapseWarning)
            return
        }
        removeBackgroundColor()
    }
    
}

import Foundation
import UIKit
