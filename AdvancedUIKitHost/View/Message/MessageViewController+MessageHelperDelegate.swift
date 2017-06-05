extension MessageViewController: MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo("Confirm error")
    }
    
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo("Confirm warning")
    }
    
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo("Cancel warning")
    }
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        SystemMessageHelper.standard?.showInfo("Confirm input \(content)")
    }
    
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo("Cancel input")
    }
    
}

import AdvancedUIKit
import UIKit
