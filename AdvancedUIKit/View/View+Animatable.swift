/// View+Animatable is used to perform an animation on a view like change the frame of a view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/08/2019
public extension UIView {
    
    /// The default animation period.
    static let defaultAnimationDuration = 0.25
    
    /// Perform an animation.
    ///
    /// - Parameters:
    ///   - change: The change to be animated.
    ///   - duration: The period of the animation.
    ///   - preparation: The action to be done before the animation.
    ///   - completion: The action to be done after the animation.
    func animateChange(_ change: @escaping () -> Void,
                       withDuration duration: Double = defaultAnimationDuration,
                       withPreparation preparation: (() -> Void)? = nil,
                       withCompletion completion: (() -> Void)? = nil) {
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
