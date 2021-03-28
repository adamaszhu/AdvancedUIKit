final class ButtonViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var checkbox: Checkbox!
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBAction func checkStatus(_ sender: Any) {
        let message = checkbox.isSelected ? Self.checkedStatusMessage : Self.uncheckedStatusMessage
        messageHelper?.showInfo(message, withTitle: Self.checkStatusTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = Self.buttonTitle
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
