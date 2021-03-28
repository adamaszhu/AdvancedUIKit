final class DeviceViewController: UIViewController {
    
    @IBOutlet private weak var systemVersionLabel: UILabel!
    @IBOutlet private weak var majorSystemVersionLabel: UILabel!
    @IBOutlet private weak var deviceLabel: UILabel!
    @IBOutlet private weak var resolutionLabel: UILabel!
    
    private lazy var deviceHelper: DeviceHelper = {
        let deviceHelper = DeviceHelper()
        deviceHelper.delegate = self
        return deviceHelper
    }()
    
    private let deviceInfoAccessor: DeviceInfoAccessor = DeviceInfoAccessor.shared
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBAction func openSetting(_ sender: Any) {
        deviceHelper.openSystemSetting()
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        deviceHelper.openWebsite(withLink: Self.website)
    }
    
    @IBAction func dialNumber(_ sender: Any) {
        deviceHelper.dialNumber(Self.number)
    }
    
    @IBAction func showMap(_ sender: Any) {
        deviceHelper.openMap(withAddress: Self.address)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        deviceHelper.sendEmail(toAddress: Self.emailAddress, withSubject: Self.emailSubject, withContent: Self.emailContent, withAttachments: [Self.emailAttachment: Data()], asHTMLContent: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        systemVersionLabel.text = String(format: Self.systemVersionPattern, deviceInfoAccessor.systemVersion)
        majorSystemVersionLabel.text = String(format: Self.majorSystemVersionPattern, deviceInfoAccessor.majorSystemVersion)
        deviceLabel.text = String(format: Self.devicePattern, deviceInfoAccessor.deviceType.rawValue)
        resolutionLabel.text = String(format: Self.resolutionPattern, deviceInfoAccessor.screenHeight, deviceInfoAccessor.screenWidth)
    }
}

extension DeviceViewController: DeviceHelperDelegate {
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String) {
        messageHelper?.showError(error)
    }
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool) {
        if result {
            messageHelper?.showInfo(Self.emailSendInfo)
        } else {
            messageHelper?.showError(Self.emailSendError)
        }
    }
}

private extension DeviceViewController {
    static let number = "+611111111111"
    static let address = "Melbourne Australia"
    static let website = "https://www.google.com"
    static let emailAddress = "info@mail.com"
    static let emailSubject = "Subject"
    static let emailContent = "<b>Content</b>"
    static let emailAttachment = "File.png"
    static let emailSendInfo = "The email has been sent successfully."
    static let emailSendError = "The email cannot be sent."
    static let systemVersionPattern = "v%@"
    static let majorSystemVersionPattern = "iOS %d"
    static let devicePattern = "Device: %@"
    static let resolutionPattern = "Screen: %.0lf * %.0lf"
}

import AdvancedUIKit
import UIKit
