final class DeviceViewController: UIViewController {
    
    static private let number = "+611111111111"
    static private let address = "Melbourne Australia"
    static private let email = (address: "info@mail.com", subject: "Subject", content: "<b>Content</b>", attachments: ["File.png": Data()])
    
    private lazy var deviceHelper: DeviceHelper = {
        let deviceHelper = DeviceHelper.standard
        deviceHelper.deviceHelperDelegate = self
        return deviceHelper
    }()
    
    @IBAction func dialNumber(_ sender: Any) {
        deviceHelper.dial(withNumber: DeviceViewController.number)
    }
    
    @IBAction func showMap(_ sender: Any) {
        deviceHelper.showMap(ofAddress: DeviceViewController.address)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        deviceHelper.email(toAddress: DeviceViewController.email.address, withSubject: DeviceViewController.email.subject, withContent: DeviceViewController.email.content, withAttachments: DeviceViewController.email.attachments, asHTMLContent: true)
    }
    
}

import AdvancedUIKit
import UIKit
