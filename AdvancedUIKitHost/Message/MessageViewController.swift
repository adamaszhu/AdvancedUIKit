class MessageViewController: UIViewController {
    
    private let systemMessageHelper: SystemMessageHelper
    //    private let customizedMessageHelper: CustomizedMessageHelper
    
    required init?(coder aDecoder: NSCoder) {
        systemMessageHelper = SystemMessageHelper()!
        //        customizedMessageHelper = CustomizedMessageHelper()
        super.init(coder: aDecoder)
        systemMessageHelper.messageHelperDelegate = self
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
        //customizedMessageHelper
    }
    
}

import AdvancedUIKit
import UIKit
