extension DeviceViewController: DeviceHelperDelegate {
    
    private static let emailSendInfo = "The email has been sent successfully."
    private static let emailSendError = "The email cannot be sent."
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showError(error)
    }
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool) {
        if result {
            SystemMessageHelper.standard?.showInfo(DeviceViewController.emailSendInfo)
        } else {
            SystemMessageHelper.standard?.showError(DeviceViewController.emailSendError)
        }
    }
    
}

import UIKit
import AdvancedUIKit
