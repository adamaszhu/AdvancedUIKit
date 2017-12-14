final class DeviceViewController: UIViewController {
    
    let number = "+611111111111"
    let address = "Melbourne Australia"
    let email = (address: "info@mail.com", subject: "Subject", content: "<b>Content</b>", attachments: ["File.png": Data()])
    let emailSendInfo = "The email has been sent successfully."
    let emailSendError = "The email cannot be sent."
    
    lazy var deviceHelper: DeviceHelper = {
        let deviceHelper = DeviceHelper.standard
        deviceHelper.deviceHelperDelegate = self
        return deviceHelper
    }()
    
    @IBAction func dialNumber(_ sender: Any) {
        deviceHelper.dial(withNumber: number)
    }
    
    @IBAction func showMap(_ sender: Any) {
        deviceHelper.openMap(withAddress: address)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        deviceHelper.email(toAddress: email.address, withSubject: email.subject, withContent: email.content, withAttachments: email.attachments, asHTMLContent: true)
    }
    
}

import AdvancedUIKit
import UIKit
