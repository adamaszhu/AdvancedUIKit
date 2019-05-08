/// NavigationController+Storyboard is used to add additional support for navigation between storyboards.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 02/06/2017
public extension UINavigationController {
    
    /// System error.
    private static let viewControllerError = "The view controller can not be found."
    
    /// Push the initial view controller of a storyboard.
    ///
    /// - Parameters:
    ///   - name: The name of the storyboard.
    ///   - animate: Whether animation should be performed or not.
    ///   - initialization: Initialize the view controller.
    @objc public func showInitialViewController(ofStoryboard storyboardName: String, withAnimation shouldAnimate: Bool = true, withInitialization initialization: ((UIViewController) -> Void) = { _ in }) {
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
    @objc public func showViewController(ofStoryboard storyboardName: String? = nil, withIdentifier identifier: String, withAnimation shouldAnimate: Bool = true, withInitialization initialization: ((UIViewController) -> Void) = { _ in }) {
        let storyboard: UIStoryboard
        if let storyboardName = storyboardName {
          storyboard  = .init(name: storyboardName, bundle: nil)
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

import UIKit
