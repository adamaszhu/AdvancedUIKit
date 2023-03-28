#if !os(macOS)
/// FadeOutAnimator is used to fade out a new view controller.
///
/// - author: Adamas
/// - version: 1.7.3
/// - date: 18/09/2021
public final class FadeOutAnimator: Animator {

    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }

        fromViewController.view.animateChange({
            fromViewController.view.alpha = 0
        }, preparation: {
            fromViewController.view.alpha = 1
        }, completion: {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

import UIKit
#endif
