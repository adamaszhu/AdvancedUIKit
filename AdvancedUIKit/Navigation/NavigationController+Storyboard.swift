//import UIKit
//
///**
// * NavigationController+Storyboard is used to add additional support for navigation between storyboards.
// * - version: 0.0.2
// * - date: 11/10/2016
// * - author: Adamas
// */
//public extension UINavigationController {
//    
//    /**
//     * System error.
//     */
//    private static let ViewControllerError = "The view controller can not be found."
//    
//    /**
//     * Push the initial view controller within the storyboard.
//     * - version: 0.0.2
//     * - date: 11/10/2016
//     * - parameter name: The name of the storyboard.
//     * - parameter initialize: Initialize the view controller.
//     * - parameter animate: Whether animation should be performed or not.
//     */
//    public func showInitialViewController(ofStoryboard storyboardName: String, withAnimation shouldAnimate: Bool = true, withPreparationHandle willShowViewController: ((UIViewController) -> Void)? = nil) {
//        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//        let viewController = storyboard.instantiateInitialViewController()
//        if viewController == nil {
//            logError(UINavigationController.ViewControllerError)
//            return
//        }
//        willShowViewController?(viewController!)
//        pushViewController(viewController!, animated: shouldAnimate)
//    }
//    
//    /**
//     * Push a specific view controller within the storyboard.
//     * - version: 0.0.2
//     * - date: 11/10/2016
//     * - parameter name: The name of the storyboard.
//     * - parameter willShowViewController: Initialize the view controller.
//     * - parameter identifier: The id of the view controller.
//     * - parameter shouldAnimate: Whether animation should be performed or not.
//     */
//    public func showViewController(ofStoryboard name: String, withIdentifier identifier: String, withAnimation shouldAnimate: Bool = true, withPreparationHandle willShowViewController: ((UIViewController) -> Void)? = nil) {
//        let storyboard = UIStoryboard(name: name, bundle: nil)
//        let viewController = storyboard.instantiateViewControllerWithIdentifier(identifier)
//        willShowViewController?(viewController)
//        pushViewController(viewController, animated: shouldAnimate)
//    }
//    
//}
