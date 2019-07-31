final class ButtonViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var checkbox: Checkbox!
    
    @IBAction func checkStatus(_ sender: Any) {
        let message = checkbox.isSelected ? ButtonViewController.checkedStatusMessage : ButtonViewController.uncheckedStatusMessage
        SystemMessageHelper.standard?.showInfo(message, withTitle: ButtonViewController.checkStatusTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = ButtonViewController.buttonTitle
    }
}

private extension ButtonViewController {
    
    static let buttonTitle = "Checkbox\nStatus"
    static let checkStatusTitle = "Checkbox Status"
    static let checkedStatusMessage = "Checked"
    static let uncheckedStatusMessage = "Unchecked"
}

import AdvancedUIKit
import UIKit
