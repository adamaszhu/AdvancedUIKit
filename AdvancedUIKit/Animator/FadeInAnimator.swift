#if !os(macOS)
/// FadeInAnimator is used to fade in a new view controller.
///
/// - author: Adamas
/// - version: 1.7.3
/// - date: 18/09/2021
public final class FadeInAnimator: Animator {

    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }

        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.animateChange({
            toViewController.view.alpha = 1
        }, preparation: {
            toViewController.view.alpha = 0
        }, completion: {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

import UIKit
#endif
