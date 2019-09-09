final class DeviceViewController: UIViewController {
    
    lazy var deviceHelper: DeviceHelper = {
        let deviceHelper = DeviceHelper.standard
        deviceHelper.deviceHelperDelegate = self
        return deviceHelper
    }()
    
    @IBAction func dialNumber(_ sender: Any) {
        deviceHelper.dial(withNumber: DeviceViewController.number)
    }
    
    @IBAction func showMap(_ sender: Any) {
        deviceHelper.openMap(withAddress: DeviceViewController.address)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        deviceHelper.email(toAddress: DeviceViewController.emailAddress, withSubject: DeviceViewController.emailSubject, withContent: DeviceViewController.emailContent, withAttachments: [DeviceViewController.emailAttachment: Data()], asHTMLContent: true)
    }
}

extension DeviceViewController: DeviceHelperDelegate {
    
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

private extension DeviceViewController {
    
    static let number = "+611111111111"
    static let address = "Melbourne Australia"
    static let emailAddress = "info@mail.com"
    static let emailSubject = "Subject"
    static let emailContent = "<b>Content</b>"
    static let emailAttachment = "File.png"
    static let emailSendInfo = "The email has been sent successfully."
    static let emailSendError = "The email cannot be sent."
}

import AdvancedUIKit
import UIKit
