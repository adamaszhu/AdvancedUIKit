#if !os(macOS)
/// KeyboardHelperDelegate is used to perform an action notified by KeyboardHelper.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 18/08/2019
public protocol KeyboardHelperDelegate: class {
    
    /// The last input view has returned.
    func keyboardHelperDidConfirmInput(_ keyboardHelper: KeyboardHelper)
    
    /// The content has been changed.
    ///
    /// - Parameter view: The view whose content has been changed.
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeContentOf view: UIView)
    
    /// Whether the content should be changed or not. It is mainly used to validate the new content.
    ///
    /// - Parameters:
    ///   - view: The view whose content will be changed.
    ///   - content: The new content that is going to be applied.
    /// - Returns: Whether the content should be changed or not.
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, shouldChangeContentOf view: UIView, toContent content: String) -> Bool
    
    /// A input view will start editing mode.
    ///
    /// - Parameter view: The view whose content will be changed.
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, willEditOn view: UIView)
    
    /// A input view finished enditing mode.
    ///
    /// - Parameter view: The view whose content will be changed.
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView)
}

/// Optional
public extension KeyboardHelperDelegate {
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, willEditOn view: UIView) {}
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView) {}
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeContentOf view: UIView) {}
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, shouldChangeContentOf view: UIView, toContent content: String) -> Bool { true }
}

import UIKit
#endif
