final class MessageViewController: UIViewController {
    
    private var defaultMessageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    private lazy var systemMessageHelper: SystemMessageHelper? = {
        let systemMessageHelper = SystemMessageHelper()
        systemMessageHelper?.delegate = self
        return systemMessageHelper
    }()
    
    private lazy var customizedMessageHelper: CustomizedMessageHelper = {
        let customizedMessageHelper = CustomizedMessageHelper()
        customizedMessageHelper.delegate = self
        return customizedMessageHelper
    }()
    
    @IBAction func showDefaultInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(Self.info.content)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(Self.info.content, withTitle: Self.info.title, withConfirmButtonName: Self.info.confirmButtonName)
    }
    
    @IBAction func showDefaultError(_ sender: Any) {
        systemMessageHelper?.showError(Self.error.content)
    }
    
    @IBAction func showError(_ sender: Any) {
        systemMessageHelper?.showError(Self.error.content, withTitle: Self.error.title, withConfirmButtonName: Self.error.confirmButtonName)
    }
    
    @IBAction func showDefaultWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(Self.warning.content)
    }
    
    @IBAction func showWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(Self.warning.content, withTitle: Self.warning.title, withConfirmButtonName: Self.warning.confirmButtonName, withCancelButtonName: Self.warning.cancelButtonName)
    }
    
    @IBAction func showDefaultInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: Self.input.title)
    }
    
    @IBAction func showInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: Self.input.title, withConfirmButtonName: Self.input.confirmButtonName, withCancelButtonName: Self.input.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(Self.info.content)
    }
    
    @IBAction func showCustomizedInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(Self.longInfo.content, withTitle: Self.longInfo.title, withConfirmButtonName: Self.longInfo.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultError(_ sender: Any) {
        customizedMessageHelper.showError(Self.error.content)
    }
    
    @IBAction func showCustomizedError(_ sender: Any) {
        customizedMessageHelper.showError(Self.error.content, withTitle: Self.error.title, withConfirmButtonName: Self.error.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(Self.warning.content)
    }
    
    @IBAction func showCustomizedWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(Self.warning.content, withTitle: Self.warning.title, withConfirmButtonName: Self.warning.confirmButtonName, withCancelButtonName: Self.warning.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: Self.input.title)
    }
    
    @IBAction func showCustomizedInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: Self.input.title, withConfirmButtonName: Self.input.confirmButtonName, withCancelButtonName: Self.input.cancelButtonName)
    }
}

extension MessageViewController: MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(Self.errorConfirmation)
    }
    
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(Self.warningConfirmation)
    }
    
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(Self.warningCancellation)
    }
    
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {
        let message = String(format: Self.inputConfirmationPattern, content)
        defaultMessageHelper?.showInfo(message)
    }
    
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) {
        defaultMessageHelper?.showInfo(Self.inputCancellation)
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
