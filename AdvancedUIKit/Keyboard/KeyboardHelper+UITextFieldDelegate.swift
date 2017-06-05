/**
 * KeyboardHelper+UITextFieldDelegate implements the action on a text field.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2017
 */
extension KeyboardHelper: UITextFieldDelegate {
    
    
    //
    //    /**
    //     * UITextFieldDelegate
    //     */
    //    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    //        changeInputView(textField)
    //        return true
    //    }
    //
    //    /**
    //     * UITextFieldDelegate
    //     */
    //    public func textFieldShouldReturn(textField: UITextField) -> Bool {
    //        finishInput(onView: textField)
    //        return false
    //    }
    //
    //    /**
    //     * UITextFieldDelegate
    //     */
    //    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    //        if (keyboardHelperDelegate != nil) && keyboardHelperDelegate!.respondsToSelector(#selector(keyboardHelperDelegate!.keyboardHelperShouldChangeContent(_:ofInputView:toContent:))) {
    //            let newContent = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    //            return keyboardHelperDelegate!.keyboardHelperShouldChangeContent!(self, ofInputView: textField, toContent: newContent)
    //        }
    //        return true
    //    }
    //
    //    /**
    //     * UITextFieldDelegate
    //     */
    //    public func textFieldDidBeginEditing(textField: UITextField) {
    //        // COMMENT: Change the color of the underline.
    //        let underline = findUnderlineForInputView(textField)
    //        if underline != nil {
    //            underline!.backgroundColor = selectedInputViewUnderlineColor
    //        }
    //        keyboardHelperDelegate?.keyboardHelperWillEdit?(self, onInputView: textField)
    //    }
    //
    //    /**
    //     * UITextFieldDelegate
    //     */
    //    public func textFieldDidEndEditing(textField: UITextField) {
    //        // COMMENT: Change the color of the underline.
    //        let underline = findUnderlineForInputView(textField)
    //        if underline != nil {
    //            underline!.backgroundColor = unselectedInputViewUnderlineColor
    //        }
    //        keyboardHelperDelegate?.keyboardHelperDidEdit?(self, onInputView: textField)
    //    }
    
}

import UIKit
