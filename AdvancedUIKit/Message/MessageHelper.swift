/**
 * MessageHelper is used to display a message on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 18/10/2017
 */
public class MessageHelper {
    
    /**
     * Get the shared instance of the MessageHelper. If the protocol will be implemented, please create a new object.
     */
    public static let standard: MessageHelper? = MessageHelper()
    
    /**
     * Default message title.
     */
    private static let successTitle = "Success".localizeWithinFramework(forType: MessageHelper.self)
    private static let warningTitle = "Warning".localizeWithinFramework(forType: MessageHelper.self)
    private static let errorTitle = "Error".localizeWithinFramework(forType: MessageHelper.self)
    
    /**
     * The name of the button.
     */
    private static let infoConfirmButtonName = "Ok".localizeWithinFramework(forType: MessageHelper.self)
    private static let warningConfirmButtonName = "Yes".localizeWithinFramework(forType: MessageHelper.self)
    private static let warningCancelButtonName = "No".localizeWithinFramework(forType: MessageHelper.self)
    private static let errorConfirmButtonName = "Ok".localizeWithinFramework(forType: MessageHelper.self)
    private static let inputConfirmButtonName = "Done".localizeWithinFramework(forType: MessageHelper.self)
    private static let inputCancelButtonName = "Cancel".localizeWithinFramework(forType: MessageHelper.self)
    
    /**
     * Error message.
     */
    private let windowError = "The window presented is invalid."
    private let typeError = "The message type is unknown."
    
    /**
     * The delegate of the MessageHelper.
     */
    public var messageHelperDelegate: MessageHelperDelegate?
    
    /**
     * The root view controller.
     */
    private let rootViewController: UIViewController
    
    /**
     * The type of current message.
     */
    private var messageType: MessageType
    
    /**
     * Current message controller.
     */
    private var alertController: UIAlertController!
    
    /**
     * Popup an information message.
     * - parameter title: The title of the message.
     * - parameter content: The content.
     * - parameter confirmButtonName: The name of the confirm button.
     */
    public func showInfo(withTitle title: String = successTitle, withContent content: String, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
        showMessage()
    }
    
    /**
     * Popup a warning message.
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     * - parameter confirmButtonName: The name of the confirm button.
     * - parameter cancelButtonName: The name of the cancel button.
     */
    public func showWarning(withTitle title: String = warningTitle, withContent content: String, withConfirmButtonName confirmButtonName: String = warningConfirmButtonName, withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
        hidePreviousMessage()
        messageType = .warning
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
        showMessage()
    }
    
    /**
     * Popup an error message.
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     * - parameter confirmButtonName: The name of the confirm button.
     */
    public func showError(withTitle title: String = errorTitle, withContent content: String, withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
        hidePreviousMessage()
        messageType = .error
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
        showMessage()
    }
    
    /**
     * Show an input box.
     * - parameter title: The title of the message.
     * - parameter confirmButtonName: The name of the confirm button.
     * - parameter cancelButtonName: The name of the cancel button.
     */
    public func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String = inputConfirmButtonName, withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
        hidePreviousMessage()
        messageType = .input
        createMessage(withTitle: title, withContent: nil, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
        alertController.addTextField(configurationHandler: nil)
        showMessage()
    }
    
    /**
     * Initialize the helper.
     * - parameter application: The application used to make a function call.
     */
    public init?(application: UIApplication = UIApplication.shared) {
        guard let rootViewController = application.keyWindow?.rootViewController else {
            Logger.standard.logError(windowError)
            return nil
        }
        let navigationController = rootViewController as? UINavigationController
        self.rootViewController = navigationController?.viewControllers.last ?? rootViewController
        messageType = .unknown
    }
    
    /**
     * Create an alert controller including a message.
     * - parameter title: The title.
     * - parameter content: The content of the message. Nil means that it is an input message.
     * - parameter confirmButtonName: The name of the confirm button.
     * - parameter cancelButtonName: The name of the cancel button. If this is nil, the confirm button will not be shown.
     */
    private func createMessage(withTitle title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String, withCancelButtonName cancelButtonName: String? = nil) {
        alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        if let cancelButtonName = cancelButtonName {
            let cancelAction = UIAlertAction(title: cancelButtonName, style: .default) { [unowned self] (action: UIAlertAction) -> Void in
                switch self.messageType {
                case .info:
                    break
                case .error:
                    break
                case .warning:
                    self.messageHelperDelegate?.messageHelperDidCancelWarning(self)
                    break
                case .input:
                    self.messageHelperDelegate?.messageHelperDidCancelInput(self)
                    break
                case .unknown:
                    Logger.standard.logError(self.typeError)
                    break
                }
            }
            alertController.addAction(cancelAction)
        }
        let confirmAction = UIAlertAction(title: confirmButtonName, style: .default) { [unowned self] (action: UIAlertAction) -> Void in
            switch self.messageType {
            case .info:
                break
            case .error:
                self.messageHelperDelegate?.messageHelperDidConfirmError(self)
                break
            case .warning:
                self.messageHelperDelegate?.messageHelperDidConfirmWarning(self)
                break
            case .input:
                self.messageHelperDelegate?.messageHelper(self, didConfirmInput: self.alertController.textFields?[0].text ?? "")
            case .unknown:
                Logger.standard.logError(self.typeError)
                break
            }
        }
        alertController.addAction(confirmAction)
    }
    
    /**
     * Show the alert controller with the message.
     */
    private func showMessage() {
        var currentController: UIViewController
        if let navigationController = rootViewController as? UINavigationController {
            currentController = navigationController.viewControllers.last ?? navigationController
        } else {
            currentController = rootViewController
        }
        currentController.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Hide previous message.
     */
    private func hidePreviousMessage() {
        if let previousAlertController = alertController {
            previousAlertController.navigationController?.popViewController(animated: false)
            messageType = .unknown
            alertController = nil
        }
    }
    
}

import UIKit
