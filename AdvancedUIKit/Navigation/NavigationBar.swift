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
            if topItem?.rightBarButtonItem == nil {
                topItem?.rightBarButtonItem = UIBarButtonItem()
            }
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
            if topItem?.leftBarButtonItem == nil {
                topItem?.leftBarButtonItem = UIBarButtonItem()
            }
            topItem?.leftBarButtonItem?.title = newValue
        }
        get {
            return topItem?.leftBarButtonItem?.title
        }
    }
    
    private var leftButton: UIBarButtonItem {
        guard let leftButton = topItem?.rightBarButtonItem else {
            let button = UIBarButtonItem()
            topItem?.rightBarButtonItem = button
            return button
        }
        return leftButton
    }
    
    /**
     * Back to previous view controller.
     */
    @IBAction func back(_ sender: Any) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
}

import UIKit
