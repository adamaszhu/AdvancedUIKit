final class MessageViewController: UIViewController {
    
    private var defaultMessageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    private lazy var systemMessageHelper: SystemMessageHelper? = {
        let systemMessageHelper = SystemMessageHelper()
        systemMessageHelper?.messageHelperDelegate = self
        return systemMessageHelper
    }()
    
    private lazy var customizedMessageHelper: CustomizedMessageHelper = {
        let customizedMessageHelper = CustomizedMessageHelper()
        customizedMessageHelper.messageHelperDelegate = self
        return customizedMessageHelper
    }()
    
    @IBAction func showDefaultInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(MessageViewController.info.content)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(MessageViewController.info.content, withTitle: MessageViewController.info.title, withConfirmButtonName: MessageViewController.info.confirmButtonName)
    }
    
    @IBAction func showDefaultError(_ sender: Any) {
        systemMessageHelper?.showError(MessageViewController.error.content)
    }
    
    @IBAction func showError(_ sender: Any) {
        systemMessageHelper?.showError(MessageViewController.error.content, withTitle: MessageViewController.error.title, withConfirmButtonName: MessageViewController.error.confirmButtonName)
    }
    
    @IBAction func showDefaultWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(MessageViewController.warning.content)
    }
    
    @IBAction func showWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(MessageViewController.warning.content, withTitle: MessageViewController.warning.title, withConfirmButtonName: MessageViewController.warning.confirmButtonName, withCancelButtonName: MessageViewController.warning.cancelButtonName)
    }
    
    @IBAction func showDefaultInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: MessageViewController.input.title)
    }
    
    @IBAction func showInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: MessageViewController.input.title, withConfirmButtonName: MessageViewController.input.confirmButtonName, withCancelButtonName: MessageViewController.input.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(MessageViewController.info.content)
    }
    
    @IBAction func showCustomizedInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(MessageViewController.longInfo.content, withTitle: MessageViewController.longInfo.title, withConfirmButtonName: MessageViewController.longInfo.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultError(_ sender: Any) {
        customizedMessageHelper.showError(MessageViewController.error.content)
    }
    
    @IBAction func showCustomizedError(_ sender: Any) {
        customizedMessageHelper.showError(MessageViewController.error.content, withTitle: MessageViewController.error.title, withConfirmButtonName: MessageViewController.error.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(MessageViewController.warning.content)
    }
    
    @IBAction func showCustomizedWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(MessageViewController.warning.content, withTitle: MessageViewController.warning.title, withConfirmButtonName: MessageViewController.warning.confirmButtonName, withCancelButtonName: MessageViewController.warning.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: MessageViewController.input.title)
    }
    
    @IBAction func showCustomizedInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: MessageViewController.input.title, withConfirmButtonName: MessageViewController.input.confirmButtonName, withCancelButtonName: MessageViewController.input.cancelButtonName)
    }
}

extension MessageViewController: MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(MessageViewController.errorConfirmation)
    }
    
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(MessageViewController.warningConfirmation)
    }
    
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(MessageViewController.warningCancellation)
    }
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        let message = String(format: MessageViewController.inputConfirmationPattern, content)
        defaultMessageHelper?.showInfo(message)
    }
    
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(MessageViewController.inputCancellation)
    }
}

private extension MessageViewController {
    static let info = (content: "This is a message.", title: "Information", confirmButtonName: "Confirm")
    static let longInfo = (content: "This is a very very very long message.", title: "Information", confirmButtonName: "Confirm")
    static let error = (content: "This is an error.", title: "Error", confirmButtonName: "Confirm")
    static let warning = (content: "This is a warning.", title: "Warning", confirmButtonName: "Confirm", cancelButtonName: "Cancel")
    static let input = (title: "Input", confirmButtonName: "Confirm", cancelButtonName: "Cancel")
    static let errorConfirmation = "Confirm error"
    static let warningConfirmation = "Confirm warning"
    static let warningCancellation = "Cancel warning"
    static let inputConfirmationPattern = "Confirm input %s"
    static let inputCancellation = "Cancel input"
}

import AdvancedUIKit
import UIKit
