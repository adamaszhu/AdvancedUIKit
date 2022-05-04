#if !os(macOS)
/// Animator is used to show a new view controller with defined animation.
///
/// - author: Adamas
/// - version: 1.7.3
/// - date: 18/09/2021
open class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}

    public func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        UIView.defaultAnimationDuration
    }
}

import UIKit
#endif
