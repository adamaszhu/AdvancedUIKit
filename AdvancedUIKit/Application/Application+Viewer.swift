/**
 * Application+Viewer extracts the attributes related to the view in the app.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public extension UIApplication {
    
    /**
     * System error.
     */
    private static let windowError = "The window presented is invalid."
    
    /**
     * System warning.
     */
    private static let navigationWarning = "The view doesn't have a navigation controller."
    
    /**
     * The current view controller.
     */
    public var currentViewController: UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.viewControllers.last ?? navigationController
        } else {
            Logger.standard.logWarning(UIApplication.navigationWarning)
            return rootViewController
        }
    }
    
    /**
     * The root view controller.
     */
    public var rootViewController: UIViewController? {
        guard let window = keyWindow else {
            Logger.standard.logError(UIApplication.windowError)
            return nil
        }
        return window.rootViewController
    }
    
}

import UIKit
