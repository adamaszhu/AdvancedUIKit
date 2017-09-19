final class MessageViewController: UIViewController {
    
    let info = (content: "This is a message.", title: "Information", confirmButtonName: "Confirm")
    let longInfo = (content: "This is a very very very long message.", title: "Information", confirmButtonName: "Confirm")
    let error = (content: "This is an error.", title: "Error", confirmButtonName: "Confirm")
    let warning = (content: "This is a warning.", title: "Warning", confirmButtonName: "Confirm", cancelButtonName: "Cancel")
    let input = (title: "Input", confirmButtonName: "Confirm", cancelButtonName: "Cancel")
    
    private lazy var systemMessageHelper: SystemMessageHelper? = {
        let systemMessageHelper = SystemMessageHelper.standard
        systemMessageHelper?.messageHelperDelegate = self
        return systemMessageHelper
    }()
    
    private lazy var customizedMessageHelper: CustomizedMessageHelper = {
        let customizedMessageHelper = CustomizedMessageHelper.standard
        customizedMessageHelper.messageHelperDelegate = self
        return customizedMessageHelper
    }()
    
    @IBAction func showDefaultInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(info.content)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        systemMessageHelper?.showInfo(info.content, withTitle: info.title, withConfirmButtonName: info.confirmButtonName)
    }
    
    @IBAction func showDefaultError(_ sender: Any) {
        systemMessageHelper?.showError(error.content)
    }
    
    @IBAction func showError(_ sender: Any) {
        systemMessageHelper?.showError(error.content, withTitle: error.title, withConfirmButtonName: error.confirmButtonName)
    }
    
    @IBAction func showDefaultWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(warning.content)
    }
    
    @IBAction func showWarning(_ sender: Any) {
        systemMessageHelper?.showWarning(warning.content, withTitle: warning.title, withConfirmButtonName: warning.confirmButtonName, withCancelButtonName: warning.cancelButtonName)
    }
    
    @IBAction func showDefaultInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: input.title)
    }
    
    @IBAction func showInput(_ sender: Any) {
        systemMessageHelper?.showInput(withTitle: input.title, withConfirmButtonName: input.confirmButtonName, withCancelButtonName: input.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(info.content)
    }
    
    @IBAction func showCustomizedInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(info.content, withTitle: info.title, withConfirmButtonName: info.confirmButtonName)
    }
    
    @IBAction func showCustomizedLongInfo(_ sender: Any) {
        customizedMessageHelper.showInfo(longInfo.content, withTitle: longInfo.title, withConfirmButtonName: longInfo.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultError(_ sender: Any) {
        customizedMessageHelper.showError(error.content)
    }
    
    @IBAction func showCustomizedError(_ sender: Any) {
        customizedMessageHelper.showError(error.content, withTitle: error.title, withConfirmButtonName: error.confirmButtonName)
    }
    
    @IBAction func showCustomizedDefaultWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(warning.content)
    }
    
    @IBAction func showCustomizedWarning(_ sender: Any) {
        customizedMessageHelper.showWarning(warning.content, withTitle: warning.title, withConfirmButtonName: warning.confirmButtonName, withCancelButtonName: warning.cancelButtonName)
    }
    
    @IBAction func showCustomizedDefaultInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: input.title)
    }
    
    @IBAction func showCustomizedInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: input.title, withConfirmButtonName: input.confirmButtonName, withCancelButtonName: input.cancelButtonName)
    }
    
}

import AdvancedUIKit
import UIKit
