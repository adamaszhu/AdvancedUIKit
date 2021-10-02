#if !os(macOS)
/// ModalViewController is used to present a view controller modally.
///
/// - author: Adamas
/// - version: 1.7.3
/// - date: 02/10/2021
open class ModalViewController: UIViewController {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }

    /// Initialize the view controller
    private func initialize() {
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
}

extension ModalViewController: UIViewControllerTransitioningDelegate {

    public func animationController(forPresented _: UIViewController,
                                    presenting _: UIViewController,
                                    source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeInAnimator()
    }

    public func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeOutAnimator()
    }
}

import UIKit
#endif
