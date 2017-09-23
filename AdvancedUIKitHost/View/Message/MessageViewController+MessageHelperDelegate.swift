extension MessageViewController: MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo(errorConfirmation)
    }
    
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo(warningConfirmation)
    }
    
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo(warningCancellation)
    }
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        let message = String(format: inputConfirmationPattern, content)
        SystemMessageHelper.standard?.showInfo(message)
    }
    
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) {
        SystemMessageHelper.standard?.showInfo(inputCancellation)
    }
    
}

import AdvancedUIKit
import UIKit
