/// CustomizedMessageHelper+Helper defines the action that a message helper should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
extension CustomizedMessageHelper: MessageHelper {
    
    public func showInfo(_ content: String, withTitle title: String = successTitle, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        showMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
    }
    
    public func showWarning(_ content: String, withTitle title: String = warningTitle, withConfirmButtonName confirmButtonName: String = warningConfirmButtonName, withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
        hidePreviousMessage()
        messageType = .warning
        showMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
    }
    
    public func showError(_ content: String, withTitle title: String = errorTitle, withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
        hidePreviousMessage()
        messageType = .error
        showMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
    }
    
    public func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String = inputConfirmButtonName, withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
        hidePreviousMessage()
        messageType = .input
        showMessage(withTitle: title, withContent: nil, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
    }
    
}

import Foundation
