/**
 * ViewController+Navigation profide additional support related to the navigation.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public extension UIViewController {
    
    /**
     * Whether the view controller is a root view controller or not.
     */
    public var isRootViewController: Bool {
        guard let navigationController = navigationController else {
            return true
        }
        return navigationController.viewControllers.index(of: self) == 0
    }
    
}

import UIKit
