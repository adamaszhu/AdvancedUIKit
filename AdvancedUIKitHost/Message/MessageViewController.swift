class MessageViewController: UIViewController {
    
    private let messageHelper: MessageHelper
    
    required init?(coder aDecoder: NSCoder) {
        messageHelper = MessageHelper()!
        super.init(coder: aDecoder)
        messageHelper.messageHelperDelegate = self
    }
    
    @IBAction func showDefaultInfo(_ sender: Any) {
        messageHelper.showInfo("This is a message.")
    }
    
    @IBAction func showInfo(_ sender: Any) {
        messageHelper.showInfo("This is a message.", withTitle: "Information", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showDefaultError(_ sender: Any) {
        messageHelper.showError("This is an error.")
    }
    
    @IBAction func showError(_ sender: Any) {
        messageHelper.showError("This is an error.", withTitle: "Error", withConfirmButtonName: "Confirm")
    }
    
    @IBAction func showDefaultWarning(_ sender: Any) {
        messageHelper.showWarning("This is a warning.")
    }
    
    @IBAction func showWarning(_ sender: Any) {
        messageHelper.showWarning("This is a warning.", withTitle: "Warning", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
    @IBAction func showDefaultInput(_ sender: Any) {
        messageHelper.showInput(withTitle: "Input")
    }
    
    @IBAction func showInput(_ sender: Any) {
        messageHelper.showInput(withTitle: "Input", withConfirmButtonName: "Confirm", withCancelButtonName: "Cancel")
    }
    
}

import AdvancedUIKit
import UIKit
