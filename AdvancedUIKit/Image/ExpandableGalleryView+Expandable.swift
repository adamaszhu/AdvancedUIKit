/// ExpandableGalleryView+Expandable defines what an expandable gallery view should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 19/06/2017
extension ExpandableGalleryView: ExpandableView {
    
    /// Expand the frame with animation
    private func expandFrame() {
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        let pageControlBottomMargin = self.pageControlButtomMargin
        animateChange({ [unowned self] in
            self.frame = window.bounds
            self.imageSize = window.bounds.size
            }, withPreparation: { [unowned self] in
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.pageControl.isHidden = true
            }, withCompletion: { [unowned self] in
                self.collapseGestureRecognizer.isEnabled = true
                self.pageControlButtomMargin = pageControlBottomMargin
                self.pageControl.isHidden = false
                self.addBackground()
        })
    }
    
    /// Add background color with animation.
    private func addBackground() {
        animateChange( { [unowned self] in
            self.currentGalleryImage?.imageView.backgroundColor = .black
        }) { [unowned self] in
            self.setBackgroundColor(.black)
        }
    }
    
    /// Collapse the frame with animation
    private func collapseFrame() {
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
            return
        }
        let pageControlBottomMargin = self.pageControlButtomMargin
        animateChange({ [unowned self] in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.imageSize = self.originalFrame.size
            }, withPreparation: { [unowned self] in
                self.collapseGestureRecognizer.isEnabled = false
                self.pageControl.isHidden = true
            }, withCompletion: { [unowned self] in
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
                self.pageControlButtomMargin = pageControlBottomMargin
                self.pageControl.isHidden = false
        })
    }
    
    /// Remove the background color with animation.
    private func removeBackgroundColor() {
        animateChange({ [unowned self] in
            self.currentGalleryImage?.imageView.backgroundColor = .clear
        }) { [unowned self] in
            self.setBackgroundColor(.clear)
            self.collapseFrame()
        }
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
    
    @objc public var isExpanded: Bool {
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
import Foundation
import UIKit
