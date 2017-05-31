/**
 * CustomizedMessageHelper+Helper defines the action that a message helper should do.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
extension CustomizedMessageHelper: MessageHelper {    //
    //    /**
    //     * Popup a customized info message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showInfo(withTitle title: String = SuccessTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.InfoConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.SuccessTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Info
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized warning message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showWarning(withTitle title: String = WarningTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.WarningConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedCancelButtonName = CustomizedMessageHelper.WarningCancelButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.WarningTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Warning
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized error message.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     * - parameter content: The content of the message.
    //     */
    //    public func showError(withTitle title: String = ErrorTitle, withContent content: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.ErrorConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedTitle = title == CustomizedMessageHelper.ErrorTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
    //        messageType = MessageType.Error
    //        showMessage(localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
    //    }
    //
    //    /**
    //     * Popup a customized input dialog.
    //     * - version: 0.0.4
    //     * - date: 19/10/2016
    //     * - parameter title: The title of the message.
    //     */
    //    public func showInput(withTitle title: String) {
    //        hidePreviousMessage()
    //        let localizedConfirmButtonName = CustomizedMessageHelper.InputConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
    //        let localizedCancelButtonName = CustomizedMessageHelper.InputCancelButtonName.localizeInBundle(forClass: self.classForCoder)
    //        messageType = MessageType.Input
    //        showMessage(title, withContent: nil, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName, asInputMessage: true)
    //    }
    
    /**
     * MessageHelper
     */
    public func showInfo(_ content: String, withTitle title: String = successTitle, withConfirmButtonName confirmButtonName: String = infoConfirmButtonName) {
//        hidePreviousMessage()
//        messageType = .info
//        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
//        showMessage()
    }
    
    /**
     * MessageHelper
     */
    public func showWarning(_ content: String, withTitle title: String = warningTitle, withConfirmButtonName confirmButtonName: String = warningConfirmButtonName, withCancelButtonName cancelButtonName: String = warningCancelButtonName) {
//        hidePreviousMessage()
//        messageType = .warning
//        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
//        showMessage()
    }
    
    /**
     * MessageHelper
     */
    public func showError(_ content: String, withTitle title: String = errorTitle, withConfirmButtonName confirmButtonName: String = errorConfirmButtonName) {
//        hidePreviousMessage()
//        messageType = .error
//        createMessage(withTitle: title, withContent: content, withConfirmButtonName: confirmButtonName)
//        showMessage()
    }
    
    /**
     * MessageHelper
     */
    public func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String = inputConfirmButtonName, withCancelButtonName cancelButtonName: String = inputCancelButtonName) {
//        hidePreviousMessage()
//        messageType = .input
//        createMessage(withTitle: title, withContent: nil, withConfirmButtonName: confirmButtonName, withCancelButtonName: cancelButtonName)
//        alertController.addTextField(configurationHandler: nil)
//        showMessage()
    }
    
}

import Foundation
