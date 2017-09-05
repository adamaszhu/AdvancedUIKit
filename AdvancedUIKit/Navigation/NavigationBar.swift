/// NavigationBar is used as a customized navigation bar.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 02/06/2017
public class NavigationBar: UINavigationBar {
    
    /// The view controller that the navigation bar belongs to.
    @IBOutlet public weak var viewController: UIViewController!
    
    /// Set the title of the navigation bar.
    public var title: String? {
        set {
            topItem?.title = newValue
        }
        get {
            return topItem?.title
        }
    }
    
    /// Set the title of the left navigation button.
    public var leftButtonTitle: String? {
        set {
            leftButton?.title = newValue
        }
        get {
            return leftButton?.title
        }
    }
    
    /// Set the title of the right navigation button.
    public var rightButtonTitle: String? {
        set {
            rightButton?.title = newValue
        }
        get {
            return rightButton?.title
        }
    }
    
    /// The left navigation button.
    private var leftButton: UIBarButtonItem? {
        guard let leftButton = topItem?.leftBarButtonItem else {
            topItem?.leftBarButtonItem = UIBarButtonItem()
            return topItem?.leftBarButtonItem
        }
        return leftButton
    }
    
    /// The left navigation button.
    private var rightButton: UIBarButtonItem? {
        guard let rightButton = topItem?.rightBarButtonItem else {
            topItem?.rightBarButtonItem = UIBarButtonItem()
            return topItem?.rightBarButtonItem
        }
        return rightButton
    }
    
    /// Set the action for the left button.
    ///
    /// - parameter action: The action to be settled.
    /// - parameter target: The object.
    public func setLeftButtonAction(action: Selector, withTarget target: AnyObject) {
        leftButton?.action = action
        leftButton?.target = target
    }
    
    /// Back to previous view controller.
    @IBAction public func back(_ sender: Any) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    /// Set the action for the right button.
    ///
    /// - Parameters:
    ///   - action: The action to be settled.
    ///   - target: The object.
    public func setRightButtonAction(action: Selector, withTarget target: AnyObject) {
        rightButton?.action = action
        rightButton?.target = target
    }
    
}

import UIKit
