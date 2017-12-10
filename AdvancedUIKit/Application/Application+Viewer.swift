/// Application+Viewer extracts the attributes related to the view in the app.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
public extension UIApplication {
    
    /// System error.
    private static let windowError = "The window presented is invalid."
    
    /// System warning.
    private static let navigationWarning = "The window doesn't have a navigation controller."
    
    /// The current view controller.
    @objc public var currentViewController: UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.viewControllers.last ?? navigationController
        } else {
            return rootViewController
        }
    }
    
    /// The root view controller.
    @objc public var rootViewController: UIViewController? {
        guard let window = keyWindow else {
            Logger.standard.log(error: UIApplication.windowError)
            return nil
        }
        if !(window.rootViewController is UINavigationController) {
            Logger.standard.log(warning: UIApplication.navigationWarning)
        }
        return window.rootViewController
    }
    
}

import UIKit
