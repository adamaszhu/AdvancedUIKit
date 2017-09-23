extension DeviceViewController: DeviceHelperDelegate {
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showError(error)
    }
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool) {
        if result {
            SystemMessageHelper.standard?.showInfo(emailSendInfo)
        } else {
            SystemMessageHelper.standard?.showError(emailSendError)
        }
    }
    
}

import UIKit
import AdvancedUIKit
