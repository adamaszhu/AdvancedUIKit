/**
 * View+Gesture is used to add additional function to a uiview relating to the gesture function.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 28/04/2017
 */
public extension UIView {
    
    /**
     * Enable the any gesture on the view.
     */
    public func enableAnyGesture() {
        enableGesture(ofType: UIPanGestureRecognizer.self)
        enableGesture(ofType: UITapGestureRecognizer.self)
        enableGesture(ofType: UISwipeGestureRecognizer.self)
    }
    
    /**
     * Disable the any gesture on the view.
     */
    public func disableAnyGesture() {
        disableGesture(ofType: UIPanGestureRecognizer.self)
        disableGesture(ofType: UITapGestureRecognizer.self)
        disableGesture(ofType: UISwipeGestureRecognizer.self)
    }
    
    /**
     * Enable a gesture.
     * - parameter type: The type of gesture to be disabled.
     */
    public func enableGesture(ofType type: AnyClass) {
        guard let gesture = findGesture(ofType: type) else {
            return
        }
        removeGestureRecognizer(gesture)
    }
    
    /**
     * Disable a gesture.
     * - parameter type: The gesture to be disabled.
     */
    public func disableGesture(ofType type: AnyClass) {
        guard let gesture = findGesture(ofType: type) else {
            return
        }
        gesture.addTarget(self, action: #selector(ignoreAction))
        addGestureRecognizer(gesture)
    }
    
    /**
     * Do nothing for an action.
     */
    func ignoreAction() {
    }
    
    /**
     * Find a specific type of gesture.
     * - parameter type: The type of the gesture.
     * - returns: The found gesture. Nil if it is not found.
     */
    private func findGesture(ofType type: AnyClass) -> UIGestureRecognizer? {
        if gestureRecognizers == nil {
            return nil
        }
        for gestureRecognizer in gestureRecognizers! {
            if gestureRecognizer.isKind(of: type) {
                return gestureRecognizer
            }
        }
        return nil
    }
    
}

import UIKit

