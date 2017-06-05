class KeyboardViewController: UIViewController {
    
    private let highlightedUnderlineColor = UIColor.blue
    private let underlineColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    
    private var keyboardHelper: KeyboardHelper
    
    @IBAction func submit(_ sender: Any) {
        let info = "\(firstnameText.text ?? "")\n\(lastnameText.text ?? "")\n\(mobileNumberText.text ?? "")\n\(addressLabel.text ?? "")"
        SystemMessageHelper.standard?.showInfo(info)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHelper.inputViews = [searchBar, firstnameText, lastnameText, mobileNumberText]
        firstnameText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
        lastnameText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
        mobileNumberText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        keyboardHelper = KeyboardHelper()
        super.init(coder: aDecoder)
    }
    
}

import AdvancedUIKit
import UIKit
