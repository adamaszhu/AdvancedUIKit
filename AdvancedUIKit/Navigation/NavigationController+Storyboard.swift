/**
 * NavigationController+Storyboard is used to add additional support for navigation between storyboards.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public extension UINavigationController {
    
    /**
     * System error.
     */
    private static let viewControllerError = "The view controller can not be found."
    
    /**
     * Push the initial view controller of a storyboard.
     * - parameter name: The name of the storyboard.
     * - parameter animate: Whether animation should be performed or not.
     * - parameter initialization: Initialize the view controller.
     */
    public func showInitialViewController(ofStoryboard storyboardName: String, withAnimation shouldAnimate: Bool = true, withInitialization initialization: ((UIViewController) -> Void) = { _ in }) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            Logger.standard.logError(UINavigationController.viewControllerError)
            return
        }
        initialization(viewController)
        pushViewController(viewController, animated: shouldAnimate)
    }
    
    /**
     * Push a specific view controller within the storyboard.
     * - parameter storyboardName: The name of the storyboard.
     * - parameter identifier: The id of the view controller.
     * - parameter shouldAnimate: Whether animation should be performed or not.
     * - parameter initialization: Initialize the view controller.
     */
    public func showViewController(ofStoryboard storyboardName: String, withIdentifier identifier: String, withAnimation shouldAnimate: Bool = true, withInitialization initialization: ((UIViewController) -> Void) = { _ in }) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        initialization(viewController)
        pushViewController(viewController, animated: shouldAnimate)
    }
    
}

import UIKit
