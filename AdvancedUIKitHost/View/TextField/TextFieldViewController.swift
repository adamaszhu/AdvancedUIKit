class TextFieldViewController: UIViewController {
    
    let highlightedUnderlineColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholderColor = .lightGray
        textField.activateUnderline(withNormal: .lightGray, withHignlighted: highlightedUnderlineColor)
    }
    
}

import UIKit
