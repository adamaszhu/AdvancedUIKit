class MessageViewController: UIViewController {
    
    private let systemMessageHelper: SystemMessageHelper
    private let customizedMessageHelper: CustomizedMessageHelper
    
    required init?(coder aDecoder: NSCoder) {
        systemMessageHelper = SystemMessageHelper()!
        customizedMessageHelper = CustomizedMessageHelper()
        super.init(coder: aDecoder)
        systemMessageHelper.messageHelperDelegate = self
        customizedMessageHelper.messageHelperDelegate = self
    }
    
    @IBAction func showDefaultInfo(_ sender: Any) {
        systemMessageHelper.showInfo("This is a message.")
    }
    
    @IBAction func showInfo(_ sender: Any) {
        systemMessageHelper.showInfo("This is a message.", withTitle: "Information", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showDefaultError(_ sender: Any) {
        systemMessageHelper.showError("This is an error.")
    }
    
    @IBAction func showError(_ sender: Any) {
        systemMessageHelper.showError("This is an error.", withTitle: "Error", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showDefaultWarning(_ sender: Any) {
        systemMessageHelper.showWarning("This is a warning.")
    }
    
    @IBAction func showWarning(_ sender: Any) {
        systemMessageHelper.showWarning("This is a warning.", withTitle: "Warning", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
    @IBAction func showDefaultInput(_ sender: Any) {
        systemMessageHelper.showInput(withTitle: "Input")
    }
    
    @IBAction func showInput(_ sender: Any) {
        systemMessageHelper.showInput(withTitle: "Input", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
    @IBAction func showCustomizedDefaultInfo(_ sender: Any) {
        customizedMessageHelper.showInfo("This is a message.")
    }
    
    @IBAction func showCustomizedInfo(_ sender: Any) {
        customizedMessageHelper.showInfo("This is a message.", withTitle: "Information", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showCustomizedLongInfo(_ sender: Any) {
        customizedMessageHelper.showInfo("This is a very very very long message.", withTitle: "Information", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showCustomizedDefaultError(_ sender: Any) {
        customizedMessageHelper.showError("This is an error.")
    }
    
    @IBAction func showCustomizedError(_ sender: Any) {
        customizedMessageHelper.showError("This is an error.", withTitle: "Error", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showCustomizedDefaultWarning(_ sender: Any) {
        customizedMessageHelper.showWarning("This is a warning.")
    }
    
    @IBAction func showCustomizedWarning(_ sender: Any) {
        customizedMessageHelper.showWarning("This is a warning.", withTitle: "Warning", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
    @IBAction func showCustomizedDefaultInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: "Input")
    }
    
    @IBAction func showCustomizedInput(_ sender: Any) {
        customizedMessageHelper.showInput(withTitle: "Input", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
    
    
    
    
    
    
    
    
    
    
}

import AdvancedUIKit
import UIKit
