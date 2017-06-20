/**
 * ExpandableMapView+Expandable defines what an expandable MapView should do.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 19/06/2017
 */
extension ExpandableMapView: ExpandableView {
    
    /**
     * ExpandableView
     */
    var isExpanded: Bool {
        guard superview != nil else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return false
        }
        return superview == window
    }
    
    /**
     * ExpandableView
     */
    public func expand() {
        guard !isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.expandWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        animate(withChange: { [unowned self] _ in
            self.frame = window.bounds
            self.collapseButton.alpha = 1
            }, withPreparation: { [unowned self] _ in
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.collapseButton.isHidden = false
                self.collapseButton.alpha = 0
                self.collapseButton.isUserInteractionEnabled = false
            }, withCompletion: { [unowned self] _ in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = true
        })
    }
    
    /**
     * ExpandableView
     */
    public func collapse() {
        guard isExpanded && isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.collapseWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.collapseButton.alpha = 0
            }, withPreparation: { [unowned self] _ in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = false
            }, withCompletion: { [unowned self] _ in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = true
                self.collapseButton.isHidden = true
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
        })
    }
    
}

import UIKit
