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
        case is UINavigationController:
            return (self as? UINavigationController)?.visibleViewController?.topViewController
        case is UITabBarController:
            return (self as? UITabBarController)?.selectedViewController?.topViewController
        default:
            return self
        }
    }
}

import UIKit
