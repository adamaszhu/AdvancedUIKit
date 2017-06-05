/**
 * KeyboardHelperDelegate is used to perform an action notified by KeyboardHelper.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2016
 */
public protocol KeyboardHelperDelegate {
    
    /**
     * The last input view has returned.
     */
    func keyboardHelperDidConfirmInput(_ keyboardHelper: KeyboardHelper)
    
    /**
     * The content has been changed.
     * - parameter view: The view whose content has been changed.
     */
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeContentOf view: UIView)
    
    /**
     * Whether the content should be changed or not. It is mainly used to validate the new content.
     * - parameter view: The view whose content will be changed.
     * - parameter content: The new content that is going to be applied.
     * - returns: Whether the content should be changed or not.
     */
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, shouldChangeContentOf view: UIView, toContent content: String) -> Bool
    
    /**
     * A input view will start editing mode.
     * - parameter view: The view whose content will be changed.
     */
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, willEditOn view: UIView)
    
    /**
     * A input view finished enditing mode.
     * - parameter view: The view whose content will be changed.
     */
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView)
    
}

import UIKit
