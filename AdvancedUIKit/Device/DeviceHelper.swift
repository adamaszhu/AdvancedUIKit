/// DeviceHelper is used to perform an user interaction. Such as sending an email or making a phone call.
///
/// - version: 1.1.0
/// - date: 14/12/2017
final public class DeviceHelper: NSObject {
    
    /// The singleton instance in the system.
    public static let standard = DeviceHelper()
    
    /// The delegate of the DeviceHelper.
    public var deviceHelperDelegate: DeviceHelperDelegate?
    
    /// The application used to do the action.
    private let application: UIApplication
    
    /// Open a website.
    ///
    /// - Parameter link: The website address.
    public func showWebsite(withLink link: String) {
        guard let websiteURL = URL(string: link) else {
            Logger.standard.log(info: DeviceHelper.linkError, withDetail: link)
            abort()
        }
        open(websiteURL, withError: DeviceHelper.BrowserError)
    }
    
    /// Make a phone call.
    ///
    /// - Parameter number: The phone number.
    public func dial(withNumber number: String) {
        guard let dialURL = URL(string: "\(DeviceHelper.dailPrefix)\(number)") else {
            Logger.standard.log(info: DeviceHelper.phoneNumberError, withDetail: number)
            return
        }
        open(dialURL, withError: DeviceHelper.dialError)
    }
    
    /// Show a location in the map application. Please let the user confirm the action beforehand.
    ///
    /// - Parameter address: The address to be shown.
    public func showMap(ofAddress address: String) {
        let formattedAddress = address.replacingOccurrences(of: String.space, with: String.plus)
        guard let mapURL = URL(string: "\(DeviceHelper.mapPrefix)\(formattedAddress)") else {
            Logger.standard.log(info: DeviceHelper.addressError, withDetail: address)
            return
        }
        open(mapURL, withError: DeviceHelper.mapError)
    }
    
    /// Send an email. Please let the user confirm the action beforehand. The navigation controller should be apply if there is a view hierarchy.
    ///
    /// - Pparameters:
    ///   - address: The email address.
    ///   - subject: The subject of the email.
    ///   - content: The content of the email.
    ///   - isHTMLContent: Whether the content is a html or not.
    ///   - attachments: A list of attachments of the email. It is a list of name and data pair
    public func email(toAddress address: String, withSubject subject: String, withContent content: String, withAttachments attachments: [String: Data] = [:], asHTMLContent isHTML: Bool = false) {
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
            deviceHelperDelegate?.deviceHelper(self, didCatchError: error.localizedInternalString(forType: DeviceHelper.self))
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

import Foundation
import MessageUI
