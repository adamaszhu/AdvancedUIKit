/// KeyboardHelper+UITextFieldDelegate implements the action on a text field.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
extension KeyboardHelper: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        changeInputView(textField)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishInput(onView: textField)
        return false
    }
    
    @objc func textFieldDidChangeText(textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, didChangeContentOf: textField)
    }
    
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
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, willEditOn: textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardHelperDelegate?.keyboardHelper(self, didEditOn: textField)
    }
    
}

import UIKit
