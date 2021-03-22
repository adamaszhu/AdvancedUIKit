/// NavigationItem+Accessable is used as a customized navigation bar.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 06/09/2019
public extension UINavigationItem {
    
    /// Set the title of the left navigation button.
    var leftButtonTitle: String? {
        set { leftButton?.title = newValue }
        get { leftButton?.title }
    }
    
    /// Set the title of the right navigation button.
    var rightButtonTitle: String? {
        set { rightButton?.title = newValue }
        get { rightButton?.title }
    }
    
    /// The left navigation button.
    private var leftButton: UIBarButtonItem? {
        guard let leftButton = leftBarButtonItem else {
            leftBarButtonItem = UIBarButtonItem()
            return leftBarButtonItem
        }
        return leftButton
    }
    
    /// The left navigation button.
    private var rightButton: UIBarButtonItem? {
        guard let rightButton = rightBarButtonItem else {
            rightBarButtonItem = UIBarButtonItem()
            return rightBarButtonItem
        }
        return rightButton
    }
    
    /// Set the action for the left button.
    ///
    /// - parameter action: The action to be settled.
    /// - parameter target: The object.
    func setLeftButtonAction(action: Selector, withTarget target: AnyObject) {
        leftButton?.action = action
        leftButton?.target = target
    }
    
    /// Set the action for the right button.
    ///
    /// - Parameters:
    ///   - action: The action to be settled.
    ///   - target: The object.
    func setRightButtonAction(action: Selector, withTarget target: AnyObject) {
        rightButton?.action = action
        rightButton?.target = target
    }
}

import UIKit
