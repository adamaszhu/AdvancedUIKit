/// SystemMessageHelper is used to display a system defined styled message on the screen.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/07/2019
final public class SystemMessageHelper {
    
    /// Get the shared instance of the SystemMessageHelper. If the protocol will be implemented, please create a new object.
    public static let standard = SystemMessageHelper()
    
    /// MessageHelper
    public var messageHelperDelegate: MessageHelperDelegate?
    
    /// The type of current message.
    private var messageType: MessageType
    
    /// Current message controller.
    private var alertController: UIAlertController?
    
    /// The current view controller.
    private let currentViewController: UIViewController?
    
    /// Initialize the helper.
    ///
    /// - Parameter application: The application used to make a function call.
    public init?(application: UIApplication = UIApplication.shared) {
        currentViewController = application.rootViewController
        messageType = .unknown
    }
    
    /// Create an alert controller including a message.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - content: The content of the message. Nil means that it is an input message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button. If this is nil, the confirm button will not be shown.
    func createMessage(withTitle title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String, withCancelButtonName cancelButtonName: String? = nil) {
        alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        if let cancelButtonName = cancelButtonName {
            let cancelAction = UIAlertAction(title: cancelButtonName, style: .default) { [unowned self] (action) -> Void in
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
                    Logger.standard.logError(SystemMessageHelper.typeError)
                    break
                }
            }
            alertController?.addAction(cancelAction)
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
                self.messageHelperDelegate?.messageHelper(self, didConfirmInput: self.alertController?.textFields?[0].text ?? .empty)
            case .unknown:
                Logger.standard.logError(SystemMessageHelper.typeError)
                break
            }
        }
        alertController?.addAction(confirmAction)
    }
    
    /// Show the alert controller with the message.
    func showMessage() {
        guard let alertController = alertController else {
            return
        }
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// Hide previous message.
    func hidePreviousMessage() {
        if let previousAlertController = alertController {
            previousAlertController.navigationController?.popViewController(animated: false)
            messageType = .unknown
            alertController = nil
        }
    }
}

/// MessageHelper
extension SystemMessageHelper: MessageHelper {
    
    public func showInfo(_ content: String, withTitle title: String = successTitle, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
        showMessage()
    }
    
    public func showWarning(_ content: String, withTitle title: String = warningTitle, withConfirmButtonName confirmButtonName: String = warningConfirmButtonName, withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
        hidePreviousMessage()
        messageType = .warning
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
        showMessage()
    }
    
    public func showError(_ content: String, withTitle title: String = errorTitle, withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
        hidePreviousMessage()
        messageType = .error
        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
        showMessage()
    }
    
    public func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String = inputConfirmButtonName, withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
        hidePreviousMessage()
        messageType = .input
        createMessage(withTitle: title, withContent: nil, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
        alertController?.addTextField(configurationHandler: nil)
        showMessage()
    }
}

/// Constants
extension SystemMessageHelper {
    
    /// Error message.
    static let typeError = "The message type is unknown."
}

import AdvancedFoundation
import UIKit
