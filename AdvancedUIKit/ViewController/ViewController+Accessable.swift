/// Access the view hierachy in a window.
///
/// - version: 1.9.0
/// - date: 11/04/22
/// - author: Adamas
public extension UIWindow {
    
    /// The top view controller in the view hierachy.
    var topViewController: UIViewController? {
        rootViewController?.topViewController
    }
}

public extension UIViewController {
    
    /// The top view controller from the current view.
    var topViewController: UIViewController? {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topViewController
        }
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.visibleViewController?.topViewController
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.topViewController
        default:
            return self
        }
    }
}

import UIKit
