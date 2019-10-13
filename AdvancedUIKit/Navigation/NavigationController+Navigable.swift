/// NavigationController+Navigable is used to add additional support for navigation between storyboards.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 06/09/2019
public extension UINavigationController {
    
    /// Push the initial view controller of a storyboard.
    ///
    /// - Parameters:
    ///   - name: The name of the storyboard.
    ///   - animate: Whether animation should be performed or not.
    ///   - initialization: Initialize the view controller.
    func showInitialViewController(ofStoryboard storyboardName: String, withAnimation shouldAnimate: Bool = true, initialization: ((UIViewController) -> Void) = { _ in }) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            Logger.standard.logError(UINavigationController.viewControllerError)
            return
        }
        initialization(viewController)
        pushViewController(viewController, animated: shouldAnimate)
    }
    
    /// Push a specific view controller within the storyboard.
    ///
    /// - Parameters:
    ///   - storyboardName: The name of the storyboard. Nil stands for current storyboard.
    ///   - identifier: The id of the view controller.
    ///   - shouldAnimate: Whether animation should be performed or not.
    ///   - initialization: Initialize the view controller.
    func showViewController(ofStoryboard storyboardName: String? = nil, withIdentifier identifier: String, withAnimation shouldAnimate: Bool = true, initialization: ((UIViewController) -> Void) = { _ in }) {
        let storyboard: UIStoryboard
        if let storyboardName = storyboardName {
            storyboard  = UIStoryboard(name: storyboardName, bundle: nil)
        } else if let currentStoryboard = self.storyboard {
            storyboard = currentStoryboard
        } else {
            Logger.standard.logError(UINavigationController.viewControllerError)
            return
        }
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        initialization(viewController)
        pushViewController(viewController, animated: shouldAnimate)
    }
    
}

/// Constants
private extension UINavigationController {
    
    /// System error.
    static let viewControllerError = "The view controller can not be found."
}

import AdvancedFoundation
import UIKit
