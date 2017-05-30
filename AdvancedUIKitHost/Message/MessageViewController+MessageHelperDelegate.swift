extension MessageViewController: MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) {
        MessageHelper.standard?.showInfo("Confirm error")
    }
    
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        MessageHelper.standard?.showInfo("Confirm warning")
    }
    
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) {
        MessageHelper.standard?.showInfo("Cancel warning")
        
    }
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        MessageHelper.standard?.showInfo("Confirm input \(content)")
        
    }
    
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) {
        MessageHelper.standard?.showInfo("Cancel input")
        
    }
    
}

import AdvancedUIKit
import UIKit
