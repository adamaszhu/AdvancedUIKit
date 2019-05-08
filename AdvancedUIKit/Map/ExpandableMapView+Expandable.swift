/// ExpandableMapView+Expandable defines what an expandable MapView should do.
///
/// - author: Adamas
/// - version: 1.4.0
/// - date: 23/08/2018
extension ExpandableMapView: ExpandableView {
    
    var isExpanded: Bool {
        guard let _ = superview else {
            Logger.standard.logError(ExpandableMapView.superviewError)
            return false
        }
        return superview == window
    }
    
    @objc public func expand() {
        guard !isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.expandingWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        saveOriginalConstraints(of: self)
        animate(withChange: { [unowned self] in
            self.frame = window.bounds
            self.collapseButton.alpha = 1
            self.collapseButtonBackgroundView.alpha = 1
            }, withPreparation: { [unowned self] in
                self.gestureFilterView.isHidden = true
                self.moveToWindow(of: self)
                self.collapseButton.isHidden = false
                self.collapseButton.alpha = 0
                self.collapseButton.isUserInteractionEnabled = false
                self.collapseButtonBackgroundView.isHidden = false
                self.collapseButtonBackgroundView.alpha = 0
            }, withCompletion: { [unowned self] in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = true
                self.collapseButtonBackgroundView.alpha = 1
        })
    }
    
    @objc public func collapse() {
        guard isExpanded, isExpandable else {
            Logger.standard.logWarning(ExpandableMapView.collapsingWarning)
            return
        }
        guard let window = window else {
            Logger.standard.logError(ExpandableMapView.windowError)
            return
        }
        animate(withChange: { [unowned self] in
            self.frame = window.convert(self.originalFrame, from: self.originalSuperview)
            self.collapseButton.alpha = 0
            self.collapseButtonBackgroundView.alpha = 0
            }, withPreparation: { [unowned self] in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = false
                self.collapseButtonBackgroundView.alpha = 1
            }, withCompletion: { [unowned self] in
                self.collapseButton.alpha = 1
                self.collapseButton.isUserInteractionEnabled = true
                self.collapseButton.isHidden = true
                self.collapseButtonBackgroundView.isHidden = true
                self.collapseButtonBackgroundView.alpha = 1
                self.removeFromWindow(of: self)
                self.gestureFilterView.isHidden = false
        })
    }
    
}

import UIKit
