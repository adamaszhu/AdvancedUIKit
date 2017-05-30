/**
 * DeviceHelper is used to perform an user interaction. Such as sending an email or making a phone call.
 * - version: 0.2.0
 * - date: 17/02/2017
 */
public class DeviceHelper: NSObject {
    
    /**
     * The singleton instance in the system.
     */
    public static let standard: DeviceHelper = DeviceHelper()
    
    /**
     * User error.
     */
    private let dialError = "DialError"
    private let mapError = "MapError"
    
    /**
     * System error.
     */
    private let phoneNumberError = "The phone number is invalid."
    private let addressError = "The address is incorrect."
    private let attachmentError = "The attachment is invalid."
    private let windowError = "The window presented is invalid."
    
    /**
     * Function url.
     */
    private let dailPrefix = "telprompt://"
    private let mapPrefix = "http://maps.apple.com/?q="
    
    /**
     * The delegate of the DeviceHelper.
     */
    public var deviceHelperDelegate: DeviceHelperDelegate?
    
    /**
     * The application used to do the action.
     */
    private let application: UIApplication
    
    /**
     * Make a phone call.
     * - parameter number: The phone number.
     */
    public func dial(withNumber number: String) {
        guard let dialURL = URL(string: "\(dailPrefix)\(number)") else {
            Logger.standard.logInfo(phoneNumberError, withDetail: number)
            return
        }
        open(dialURL, withError: dialError)
    }
    
    /**
     * Show a location in the map application. Please let the user confirm the action beforehand.
     * - parameter address: The address to be shown.
     */
    public func showMap(ofAddress address: String) {
        let formattedAddress = address.replacingOccurrences(of: " ", with: "+")
        guard let mapURL = URL(string: "\(mapPrefix)\(formattedAddress)") else {
            Logger.standard.logInfo(addressError, withDetail: address)
            return
        }
        open(mapURL, withError: mapError)
    }
    
    /**
     * Send an email. Please let the user confirm the action beforehand.
     * - parameter address: The email address.
     * - parameter subject: The subject of the email.
     * - parameter content: The content of the email.
     * - parameter isHTMLContent: Whether the content is a html or not.
     * - parameter attachments: A list of attachments of the email. It is a list of name and data pair
     */
    public func email(toAddress address: String, withSubject subject: String, withContent content: String, withAttachments attachments: Dictionary<String, Data> = [:], asHTMLContent isHTML: Bool = false) {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setToRecipients([address])
        mailViewController.setSubject(subject)
        for (name, data) in attachments {
            guard let mimeType = FileInfoAccessor(path: name).mimeType else {
                Logger.standard.logError(attachmentError, withDetail: name)
                continue
            }
            mailViewController.addAttachmentData(data, mimeType: mimeType, fileName: name);
        }
        mailViewController.setMessageBody(content, isHTML: isHTML)
        guard var rootViewController = application.keyWindow?.rootViewController else {
            Logger.standard.logError(windowError)
            return
        }
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.last ?? navigationController
        }
        rootViewController.present(mailViewController, animated: true, completion: nil)
    }
    
    /**
     * Open an URL.
     * - parameter url: The url to be opened.
     * - parameter message: The message to be performed if the URL is not available.
     */
    private func open(_ url: URL, withError error: String) {
        guard application.canOpenURL(url) else {
            deviceHelperDelegate?.deviceHelper(self, didCatchError: error.localizeWithinFramework(forType: DeviceHelper.self))
            return
        }
        application.open(url, options: [:], completionHandler: nil)
    }
    
    /**
     * Initialize the object.
     * - parameter application: The application used to make a function call.
     */
    public init(application: UIApplication = UIApplication.shared) {
        self.application = application
        super.init()
    }
    
}

import Foundation
import MessageUI
