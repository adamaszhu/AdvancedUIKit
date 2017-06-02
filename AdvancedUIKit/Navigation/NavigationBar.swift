/**
 * NavigationBar is used as a customized navigation bar.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public class NavigationBar: UINavigationBar {
    
    /**
     * The view controller that the navigation bar belongs to.
     */
    @IBOutlet public weak var viewController: UIViewController!
    
    /**
     * Set the title of the navigation bar.
     */
    public var title: String? {
        set {
            topItem?.title = newValue
        }
        get {
            return topItem?.title
        }
    }
    
    /**
     * Set the title of the right navigation button.
     */
    public var rightButtonTitle: String? {
        set {
            topItem?.rightBarButtonItem?.title = newValue
        }
        get {
            return topItem?.rightBarButtonItem?.title
        }
    }
    
    /**
     * Set the title of the left navigation button.
     */
    public var leftButtonTitle: String? {
        set {
            topItem?.leftBarButtonItem?.title = newValue
        }
        get {
            return topItem?.leftBarButtonItem?.title
        }
    }
    
    /**
     * Back to previous view controller.
     */
    @IBAction func back(_ sender: Any) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
}

import UIKit
