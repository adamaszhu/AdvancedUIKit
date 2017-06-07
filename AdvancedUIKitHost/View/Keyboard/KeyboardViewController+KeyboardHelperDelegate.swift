extension KeyboardViewController: KeyboardHelperDelegate {
    
    func keyboardHelperDidConfirmInput(_ keyboardHelper: KeyboardHelper) {
        submit(self)
    }
    
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView) {
        if view == searchBar {
            addressLabel.text = searchBar.text
        }
    }
    
}

import AdvancedUIKit
import UIKit
