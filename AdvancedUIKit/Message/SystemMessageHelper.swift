/// SystemMessageHelper is used to display a system defined styled message on the screen.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/07/2019
final public class SystemMessageHelper {
    
    /// MessageHelper
    public weak var delegate: MessageHelperDelegate?
    
    /// The type of current message.
    private var messageType: MessageType = .unknown
    
    /// Current message controller.
    private var alertController: UIAlertController?
    
    /// The current view controller.
    private let currentViewController: UIViewController
    
    /// Initialize the helper.
    ///
    /// - Parameter application: The application used to make a function call.
    public init?(application: UIApplication = UIApplication.shared) {
        guard let rootViewController = application.rootViewController else {
            Logger.standard.logError(Self.rootViewControllerError)
            return nil
        }
        currentViewController = rootViewController
    }
    
    /// Create an alert controller including a message.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - content: The content of the message. Nil means that it is an input message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button. If this is nil, the confirm button will not be shown.
    private func createMessage(withTitle title: String,
                               content: String?, confirmButtonName: String,
                               andCancelButtonName cancelButtonName: String?) {
        let title = title.localizedInternalString(forType: MessageHelper.self)
        let confirmButtonName = confirmButtonName.localizedInternalString(forType: MessageHelper.self)
        let cancelButtonName = cancelButtonName?.localizedInternalString(forType: MessageHelper.self)
        
        alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        if let cancelButtonName = cancelButtonName {
            let cancelAction = UIAlertAction(title: cancelButtonName, style: .default) { [weak self] action in
                guard let self = self else {
                    return
                }
                switch self.messageType {
                case .info, .error:
                    break
                case .warning:
                    self.delegate?.messageHelperDidCancelWarning(self)
                    break
                case .input:
                    self.delegate?.messageHelperDidCancelInput(self)
                    break
                case .unknown:
                    Logger.standard.logError(Self.typeError)
                    break
                }
            }
            alertController?.addAction(cancelAction)
        }
        let confirmAction = UIAlertAction(title: confirmButtonName, style: .default) { [weak self] action in
            guard let self = self else {
                return
            }
            switch self.messageType {
            case .info:
                break
            case .error:
                self.delegate?.messageHelperDidConfirmError(self)
                break
            case .warning:
                self.delegate?.messageHelperDidConfirmWarning(self)
                break
            case .input:
                self.delegate?.messageHelper(self, didConfirmInput: self.alertController?.textFields?[0].text ?? .empty)
            case .unknown:
                Logger.standard.logError(Self.typeError)
                break
            }
        }
        alertController?.addAction(confirmAction)
    }
    
    /// Show the alert controller with the message.
    private func showMessage() {
        guard let alertController = alertController else {
            return
        }
        currentViewController.present(alertController, animated: true, completion: nil)
    }
    
    /// Hide previous message.
    private func hidePreviousMessage() {
        if let previousAlertController = alertController {
            previousAlertController.dismiss(animated: false)
            messageType = .unknown
            alertController = nil
        }
    }
}

/// MessageHelper
extension SystemMessageHelper: MessageHelper {
    
    public func showInfo(_ content: String,
                         withTitle title: String = successTitle,
                         withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        createMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: nil)
        showMessage()
    }
    
    public func showWarning(_ content: String,
                            withTitle title: String = warningTitle,
                            withConfirmButtonName confirmButtonName: String = warningConfirmButtonName,
                            withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
        hidePreviousMessage()
        messageType = .warning
        createMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: cancelButtonName)
        showMessage()
    }
    
    public func showError(_ content: String,
                          withTitle title: String = errorTitle,
                          withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
        hidePreviousMessage()
        messageType = .error
        createMessage(withTitle: title, content: content, confirmButtonName: confirmButtonName, andCancelButtonName: nil)
        showMessage()
    }
    
    public func showInput(withTitle title: String,
                          withConfirmButtonName confirmButtonName: String = inputConfirmButtonName,
                          withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
        hidePreviousMessage()
        messageType = .input
        createMessage(withTitle: title, content: nil, confirmButtonName: confirmButtonName, andCancelButtonName: cancelButtonName)
        alertController?.addTextField(configurationHandler: nil)
        showMessage()
    }
}

/// Constants
private extension SystemMessageHelper {
    
    /// Error message.
    static let typeError = "The message type is unknown."
    static let rootViewControllerError = "There is no root view controller."
}

import AdvancedFoundation
import UIKit
