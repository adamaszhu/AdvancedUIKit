#if !os(macOS)
/// DeviceHelper is used to perform an user interaction. Such as sending an email or making a phone call.
///
/// - version: 1.5.0
/// - date: 17/08/2019
public final class DeviceHelper: NSObject {
    
    /// The delegate of the DeviceHelper.
    public weak var delegate: DeviceHelperDelegate?
    
    /// The application used to do the action.
    private let application: UIApplication
    
    /// Open the system setting.
    public func openSystemSetting() {
        guard let systemSettingURL = URL(string: UIApplication.openSettingsURLString) else {
            Logger.standard.logError(Self.systemLinkError)
            return
        }
        open(systemSettingURL, withError: Self.systemSettingError)
    }
    
    /// Open a website.
    ///
    /// - Parameter link: The website address.
    public func openWebsite(withLink link: String) {
        guard let websiteURL = URL(string: link) else {
            Logger.standard.logInfo(Self.linkError, withDetail: link)
            return
        }
        open(websiteURL, withError: Self.browserError)
    }
    
    /// Make a phone call.
    ///
    /// - Parameter number: The phone number.
    public func dialNumber(_ number: String) {
        guard let dialURL = URL(string: "\(Self.dailPrefix)\(number)") else {
            Logger.standard.logInfo(Self.phoneNumberError, withDetail: number)
            return
        }
        open(dialURL, withError: Self.dialError)
    }
    
    /// Show a location in the map application. Please let the user confirm the action beforehand.
    ///
    /// - Parameter address: The address to be shown.
    public func openMap(withAddress address: String) {
        let formattedAddress = address.replacingOccurrences(of: String.space, with: String.plus)
        guard let mapURL = URL(string: "\(Self.mapPrefix)\(formattedAddress)") else {
            Logger.standard.logInfo(Self.addressError, withDetail: address)
            return
        }
        open(mapURL, withError: Self.mapError)
    }
    
    /// Send an email. Please let the user confirm the action beforehand. The navigation controller should be apply if there is a view hierarchy.
    ///
    /// - Pparameters:
    ///   - address: The email address.
    ///   - subject: The subject of the email.
    ///   - content: The content of the email.
    ///   - isHTMLContent: Whether the content is a html or not.
    ///   - attachments: A list of attachments of the email. It is a list of name and data pair
    public func sendEmail(toAddress address: String,
                          withSubject subject: String,
                          withContent content: String,
                          withAttachments attachments: [String: Data] = [:],
                          asHTMLContent isHTML: Bool = false) {

        guard MFMailComposeViewController.canSendMail() else {
            Logger.standard.logInfo(Self.emailError, withDetail: address)
            delegate?.deviceHelper(self, didCatchError: Self.emailError.localizedInternalString(forType: Self.self))
            return
        }
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setToRecipients([address])
        mailViewController.setSubject(subject)
        attachments.forEach { (name, data) in
            let mimeType = FileInfoAccessor(path: name).mimeType
            mailViewController.addAttachmentData(data, mimeType: mimeType, fileName: name);
        }
        mailViewController.setMessageBody(content, isHTML: isHTML)
        application.rootViewController?.present(mailViewController, animated: true, completion: nil)
    }
    
    /// Open an URL.
    ///
    /// - Parameters:
    ///   - url: The url to be opened.
    ///   - message: The message to be performed if the URL is not available.
    private func open(_ url: URL, withError error: String) {
        guard application.canOpenURL(url) else {
            delegate?.deviceHelper(self, didCatchError: error.localizedInternalString(forType: Self.self))
            return
        }
        if #available(iOS 10.0, *) {
            application.open(url, options: [:], completionHandler: nil)
        } else {
            application.openURL(url)
        }
    }
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application used to make a function call.
    public init(application: UIApplication = UIApplication.shared) {
        self.application = application
        super.init()
    }
}

/// MFMailComposeViewControllerDelegate
extension DeviceHelper: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
        case .sent:
            delegate?.deviceHelper(self, didSendEmail: true)
        default:
            delegate?.deviceHelper(self, didSendEmail: false)
        }
    }
}

/// Constants
private extension DeviceHelper {
    
    /// User error.
    static let dialError = "DialError"
    static let mapError = "MapError"
    static let browserError = "BrowserError"
    static let systemSettingError = "SystemSettingError"
    static let emailError = "EmailError"
    
    /// System error.
    static let phoneNumberError = "The phone number is invalid."
    static let addressError = "The address is incorrect."
    static let linkError = "The link is incorrect."
    static let systemLinkError = "The system link is incorrect."
    
    /// Function url.
    static let dailPrefix = "telprompt://"
    static let mapPrefix = "http://maps.apple.com/?q="
}

import AdvancedFoundation
import MessageUI
import UIKit
#endif
