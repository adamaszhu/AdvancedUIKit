class DeviceViewController: UIViewController {
    
    private let number = "+611111111111"
    private let address = "Melbourne Australia"
    private let email = (address: "info@mail.com", subject: "Subject", content: "<b>Content</b>", attachments: ["File.png": Data()])
    
    private let deviceHelper: DeviceHelper
    
    required init?(coder aDecoder: NSCoder) {
        deviceHelper = DeviceHelper.standard
        super.init(coder: aDecoder)
        deviceHelper.deviceHelperDelegate = self
    }
    
    @IBAction func dialNumber(_ sender: Any) {
        deviceHelper.dial(withNumber: number)
    }
    
    @IBAction func showMap(_ sender: Any) {
        deviceHelper.showMap(ofAddress: address)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        deviceHelper.email(toAddress: email.address, withSubject: email.subject, withContent: email.content, withAttachments: email.attachments, asHTMLContent: true)
    }
    
}

import AdvancedUIKit
import UIKit
