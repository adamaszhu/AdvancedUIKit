#if !os(macOS)
/// NavigationBar+Accessable is used as a customized navigation bar.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 06/09/2019
public extension UINavigationBar {
    
    /// Set the title of the navigation bar.
    var title: String? {
        set { topItem?.title = newValue }
        get { topItem?.title }
    }
    
    /// Set the title of the left navigation button.
    var leftButtonTitle: String? {
        set { topItem?.leftButtonTitle = newValue }
        get { topItem?.leftButtonTitle }
    }
    
    /// Set the title of the right navigation button.
    var rightButtonTitle: String? {
        set { topItem?.rightButtonTitle = newValue }
        get { topItem?.rightButtonTitle }
    }
    
    /// Set the action for the left button.
    ///
    /// - parameter action: The action to be settled.
    /// - parameter target: The object.
    func setLeftButtonAction(action: Selector,
                             withTarget target: AnyObject) {
        topItem?.setLeftButtonAction(action: action,
                                     withTarget: target)
    }
    
    /// Set the action for the right button.
    ///
    /// - Parameters:
    ///   - action: The action to be settled.
    ///   - target: The object.
    func setRightButtonAction(action: Selector,
                              withTarget target: AnyObject) {
        topItem?.setRightButtonAction(action: action,
                                      withTarget: target)
    }
}

import UIKit
#endif
