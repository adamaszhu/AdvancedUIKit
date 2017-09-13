/// MessageHelper defines the action that a message helper should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
extension SystemMessageHelper: MessageHelper {
    
    public func showInfo(_ content: String, withTitle title: String = successTitle, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
        hidePreviousMessage()
        messageType = .info
        // TODO: Use AlertFactory instead
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
        alertController.addTextField(configurationHandler: nil)
        showMessage()
    }
    
}

import Foundation
