import UIKit

/**
 * KeyboardHelperDelegate is used to perform an action notified by KeyboardHelper.
 * - version: 0.0.4
 * - date: 16/10/2016
 * - author: Adamas
 */
@objc public protocol KeyboardHelperDelegate: NSObjectProtocol {
    
    /**
     * The last input view has returned.
     * - version: 0.0.4
     * - date: 16/10/2016
     */
    func keyboardHelperDidConfirmInput(keyboardHelper: KeyboardHelper)
    
    /**
     * The content has been changed.
     * - version: 0.0.4
     * - date: 16/10/2016
     * - parameter inputView: The view whose content has been changed.
     */
    optional func keyboardHelperDidChangeContent(keyboardHelper: KeyboardHelper, ofInputView inputView: UIView)
    
    /**
     * Whether the content should be changed or not. It is mainly used to validate the new content.
     * - version: 0.0.4
     * - date: 16/10/2016
     * - parameter inputView: The view whose content will be changed.
     * - parameter content: The new content that is going to be applied.
     * - returns: Whether the content should be changed or not.
     */
    optional func keyboardHelperShouldChangeContent(keyboardHelper: KeyboardHelper, ofInputView inputView: UIView, toContent content:NSString) -> Bool
    
    /**
     * A input view will start editing mode.
     * - version: 0.0.4
     * - date: 16/10/2016
     * - parameter inputView: The view whose content will be changed.
     */
    optional func keyboardHelperWillEdit(keyboardHelper: KeyboardHelper, onInputView inputView: UIView)
    
    /**
     * A input view finished enditing mode.
     * - version: 0.0.4
     * - date: 16/10/2016
     * - parameter inputView: The view whose content will be changed.
     */
    optional func keyboardHelperDidEdit(keyboardHelper: KeyboardHelper, onInputView inputView: UIView)
}
