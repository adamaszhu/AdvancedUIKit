/// View+Animation is used to perform an animation on a view like change the frame of a view.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 28/04/2017
public extension UIView {
    
    /// The default animation period.
    @objc public static let defaultAnimationDuration = 0.25
    
    /// Perform an animation.
    ///
    /// - Parameters:
    ///   - change: The change to be animated.
    ///   - duration: The period of the animation.
    ///   - preparation: The action to be done before the animation.
    ///   - completion: The action to be done after the animation.
    @objc public func animate(withChange change: @escaping () -> Void, withDuration duration: Double = defaultAnimationDuration, withPreparation preparation:(() -> Void)? = nil, withCompletion completion: (() -> Void)? = nil) {
        layer.removeAllAnimations()
        preparation?()
        UIView.animate(withDuration: duration, animations: {
            change()
        }) { result in
            change()
            completion?()
        }
    }
    
}

import UIKit

