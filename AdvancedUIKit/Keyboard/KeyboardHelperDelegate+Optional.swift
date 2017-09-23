/// KeyboardHelperDelegate+Optional implements the default action of the delegate.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
public extension KeyboardHelperDelegate {
    
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didChangeContentOf view: UIView) { }
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, willEditOn view: UIView) { }
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView) { }
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, shouldChangeContentOf view: UIView, toContent content: String) -> Bool { return true }
    
}

import UIKit
