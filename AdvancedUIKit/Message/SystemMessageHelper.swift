/// SystemMessageHelper is used to display a system defined styled message on the screen.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 18/10/2017
final public class SystemMessageHelper {
    
    /// Get the shared instance of the SystemMessageHelper. If the protocol will be implemented, please create a new object.
    public static let standard = SystemMessageHelper()
    
    /// The type of current message.
    var messageType: MessageType
    
    /// Current message controller.
    var alertController: UIAlertController!
    
    /// The current view controller.
    private let currentViewController: UIViewController?
    
    /// MessageHelper
    public var messageHelperDelegate: MessageHelperDelegate?
    
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
                    Logger.standard.log(error: SystemMessageHelper.typeError)
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
                Logger.standard.log(error: SystemMessageHelper.typeError)
                break
            }
        }
        alertController.addAction(confirmAction)
    }
    
    /// Show the alert controller with the message.
    func showMessage() {
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

import UIKit
