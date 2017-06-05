extension KeyboardViewController: KeyboardHelperDelegate {
    
    func keyboardHelperDidConfirmInput(_ keyboardHelper: KeyboardHelper) {
        submit(self)
    }
    
}

import AdvancedUIKit
import UIKit
