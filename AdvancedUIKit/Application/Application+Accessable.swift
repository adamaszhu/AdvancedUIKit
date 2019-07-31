/// Application+Accessable extracts the attributes related to the view in the app.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/05/2018
public extension UIApplication {
    
    /// The current view controller.
    var currentViewController: UIViewController? {
        if let rootPresentedViewController = rootViewController?.presentedViewController {
            return rootPresentedViewController
        }
        guard let navigationController = rootViewController as? UINavigationController,
            let lastViewController = navigationController.viewControllers.last else {
                return rootViewController
        }
        if let lastPresentedViewController = lastViewController.presentedViewController {
            return lastPresentedViewController
        } else {
            return lastViewController
        }
    }
    
    /// The root view controller.
    var rootViewController: UIViewController? {
        guard let window = keyWindow else {
            Logger.standard.logError(UIApplication.windowError)
            return nil
        }
        if !(window.rootViewController is UINavigationController) {
            Logger.standard.logWarning(UIApplication.navigationWarning)
        }
        return window.rootViewController
    }
}

/// Constants
private extension UIApplication {
    
    /// System error.
    static let windowError = "The window presented is invalid."
    
    /// System warning.
    static let navigationWarning = "The window doesn't have a navigation controller."
}

import UIKit
