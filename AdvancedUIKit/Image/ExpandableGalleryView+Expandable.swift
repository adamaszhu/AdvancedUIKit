/**
 * ExpandableGalleryView+Expandable defines what an expandable gallery view should do.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 19/06/2017
 */
extension ExpandableGalleryView: ExpandableView {
    
    /**
     * ExpandableView
     */
    public var isExpanded: Bool {
        guard superview != nil else {
            Logger.standard.logError(ExpandableGalleryView.superviewError)
            return false
        }
        return superview == window
    }
    
    /**
     * ExpandableView
     */
    public func expand() {
        guard !isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableGalleryView.expandWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableGalleryView.windowError)
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
                self.backgroundColor = .black
        })
    }
    
    /**
     * ExpandableView
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
        let pageControlBottomMargin = self.pageControlButtomMargin
        animate(withChange: { [unowned self] _ in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.imageSize = self.originalFrame.size
            }, withPreparation: { [unowned self] _ in
                self.collapseGestureRecognizer.isEnabled = false
                self.pageControl.isHidden = true
                self.backgroundColor = .clear
            }, withCompletion: { [unowned self] _ in
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
                self.pageControlButtomMargin = pageControlBottomMargin
                self.pageControl.isHidden = false
        })
    }
    
}

import Foundation
