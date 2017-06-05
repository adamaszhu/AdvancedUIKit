/**
 * KeyboardHelper+UITextFieldDelegate implements the action on a text field.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2017
 */
extension KeyboardHelper: UITextFieldDelegate {
    
    /**
     * UITextFieldDelegate
     */
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        changeInputView(textField)
        return true
    }
    
    /**
     * UITextFieldDelegate
     */
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishInput(onView: textField)
        return false
    }
    
    /**
     * UITextFieldDelegate
     */
    func textFieldDidChangeText(textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, didChangeContentOf: textField)
    }
    
    /**
     * UITextFieldDelegate
     */
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let keyboardHelperDelegate = keyboardHelperDelegate else {
            return true
        }
        var newContent: String
        if let originalText = textField.text as NSString? {
            newContent = originalText.replacingCharacters(in: range, with: string)
        } else {
            newContent = string
        }
        return keyboardHelperDelegate.keyboardHelper(self, shouldChangeContentOf: textField, toContent: newContent)
    }
    
    /**
     * UITextFieldDelegate
     */
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, willEditOn: textField)
    }
    
    /**
     * UITextFieldDelegate
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, didEditOn: textField)
    }
    
}

import UIKit
