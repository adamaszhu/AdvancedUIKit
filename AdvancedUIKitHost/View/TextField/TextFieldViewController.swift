final class TextFieldViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholderColor = .lightGray
        textField.activateUnderline(withNormal: .lightGray, withHignlighted: TextFieldViewController.highlightedUnderlineColor)
    }
}

private extension TextFieldViewController {
    static let highlightedUnderlineColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
}

import UIKit
