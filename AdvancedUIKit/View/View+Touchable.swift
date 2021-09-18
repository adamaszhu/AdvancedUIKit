#if !os(macOS)
/// View+Touchable is used to add additional function to a uiview relating to the gesture function.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/08/2019
public extension UIView {
    
    /// The view used to filter gestures.
    private var gestureFilterView: GestureFilterView {
        let view = subviews.first { $0 is GestureFilterView }
        if let gestureFilterView = view as? GestureFilterView {
            return gestureFilterView
        }
        // The view doesn't exist.
        let gestureFilterView = GestureFilterView(frame: bounds)
        addSubview(gestureFilterView)
        return gestureFilterView
    }
    
    /// Enable the any gesture on the view.
    func enableAnyGesture() {
        enableGesture(ofType: UIPanGestureRecognizer.self)
        enableGesture(ofType: UITapGestureRecognizer.self)
        enableGesture(ofType: UISwipeGestureRecognizer.self)
    }
    
    /// Disable the any gesture on the view.
    func disableAnyGesture() {
        disableGesture(ofType: UIPanGestureRecognizer.self)
        disableGesture(ofType: UITapGestureRecognizer.self)
        disableGesture(ofType: UISwipeGestureRecognizer.self)
    }
    
    /// Enable a gesture.
    ///
    /// - Parameter type: The type of gesture to be disabled.
    func enableGesture(ofType type: AnyClass) {
        gestureFilterView.changeGestureRecognizerUsibility(ofType: type, toUsibility: false)
    }
    
    /// Disable a gesture.
    ///
    /// - Parameter type: The gesture to be disabled.
    func disableGesture(ofType type: AnyClass) {
        gestureFilterView.changeGestureRecognizerUsibility(ofType: type, toUsibility: true)
    }
}

import UIKit
#endif
