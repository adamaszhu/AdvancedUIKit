#if !os(macOS)
/// View+Animatable is used to perform an animation on a view like change the frame of a view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/08/2019
public extension UIView {
    
    /// The default animation period.
    static let defaultAnimationDuration = 0.25
    
    /// Whether or not the view is performing an animation
    var isAnimating: Bool {
        layer.animationKeys()?.isEmpty == false
    }
    
    /// Perform an animation.
    ///
    /// - Parameters:
    ///   - change: The change to be animated.
    ///   - duration: The period of the animation.
    ///   - preparation: The action to be done before the animation.
    ///   - completion: The action to be done after the animation.
    func animateChange(_ change: @escaping () -> Void,
                       withDuration duration: Double = defaultAnimationDuration,
                       preparation: (() -> Void) = {},
                       completion: @escaping (() -> Void) = {}) {
        layer.removeAllAnimations()
        preparation()
        UIView.animate(withDuration: duration, animations: {
            change()
        }) { result in
            completion()
        }
    }
    
    /// Stop any animation executed on the current view.
    func stopAllAnimations() {
        layer.removeAllAnimations()
    }

    /// Show the view.
    /// - Parameters:
    ///   - duration: Duration of the animation.
    ///   - completion: Callback when the view is shown.
    func show(withDuration duration: Double = defaultAnimationDuration,
              completion: @escaping (() -> Void) = {}) {
        guard isHidden else {
            return
        }
        animateChange({ [weak self] in
            self?.alpha = Alpha.visible.rawValue
        }, withDuration: duration,
                      preparation: {
            alpha = Alpha.hidden.rawValue
        }, completion: { [weak self] in
            self?.isHidden = false
        })
    }

    /// Hide the view.
    /// - Parameters:
    ///   - duration: Duration of the animation.
    ///   - completion: Callback when the view is shown.
    func hide(withDuration duration: Double = defaultAnimationDuration,
              completion: @escaping (() -> Void) = {}) {
        guard !isHidden else {
            return
        }
        animateChange({ [weak self] in
            self?.alpha = Alpha.hidden.rawValue
        }, withDuration: duration,
                      preparation: {
            alpha = Alpha.visible.rawValue
        }, completion: { [weak self] in
            self?.isHidden = true
        })
    }
}

import UIKit
#endif
