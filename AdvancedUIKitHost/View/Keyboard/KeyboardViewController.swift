class KeyboardViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    
    private let keyboardHelper: KeyboardHelper
    
    required init?(coder aDecoder: NSCoder) {
        keyboardHelper = KeyboardHelper()
        super.init(coder: aDecoder)
    }
    
    @IBAction func submit(_ sender: Any) {
        let info = "\(firstnameText.text ?? "")/n\(lastnameText.text ?? "")/n\(mobileNumberText.text ?? "")/n\(addressLabel.text ?? "")"
        SystemMessageHelper.standard?.showInfo(info)
    }
    
}

import AdvancedUIKit
import UIKit
