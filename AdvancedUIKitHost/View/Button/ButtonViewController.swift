final class ButtonViewController: UIViewController {
    
    let buttonTitle = "Checkbox\nStatus"
    let checkStatusTitle = "Checkbox Status"
    let checkedStatusMessage = "Checked"
    let uncheckedStatusMessage = "Unchecked"
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var checkbox: Checkbox!
    
    @IBAction func checkStatus(_ sender: Any) {
        let message = checkbox.isSelected ? checkedStatusMessage : uncheckedStatusMessage
        SystemMessageHelper.standard?.showInfo(message, withTitle: checkStatusTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = buttonTitle
    }
    
}

import AdvancedUIKit
import UIKit
