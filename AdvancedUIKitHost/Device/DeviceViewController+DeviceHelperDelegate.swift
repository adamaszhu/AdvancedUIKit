extension DeviceViewController: DeviceHelperDelegate {
    
    private static let emailSendInfo = "The email has been sent successfully."
    private static let emailSendError = "The email cannot be sent."
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String) {
        MessageHelper.standard?.showError(error)
    }
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool) {
        let message = result ? DeviceViewController.emailSendInfo : DeviceViewController.emailSendError
        MessageHelper.standard?.showError(message)
    }
    
}

import UIKit
import AdvancedUIKit
