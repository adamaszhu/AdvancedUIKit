final class KeyboardViewController: UIViewController {
    
    let highlightedUnderlineColor = UIColor(red: 125/255, green: 182/255, blue: 216/255, alpha: 1)
    let underlineColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
    let submissionPattern = "Firstname: %s\nLastname: %s\nMobile: %s\nAddress: %s"
    let emptyString = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    
    private lazy var keyboardHelper: KeyboardHelper = {
        let keyboardHelper = KeyboardHelper()
        keyboardHelper.keyboardHelperDelegate = self
        return keyboardHelper
    }()
    
    @IBAction func submit(_ sender: Any) {
        let firstname = firstnameText.text ?? emptyString
        let lastname = lastnameText.text ?? emptyString
        let mobileNumber = mobileNumberText.text ?? emptyString
        let address = addressLabel.text ?? emptyString
        let info = String(format: submissionPattern, firstname, lastname, mobileNumber, address)
        SystemMessageHelper.standard?.showInfo(info)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
        lastnameText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
        mobileNumberText.activateUnderline(withNormal: underlineColor, withHignlighted: highlightedUnderlineColor)
        keyboardHelper.rootView = view
        keyboardHelper.inputViews = [searchBar, firstnameText, lastnameText, mobileNumberText]
        keyboardHelper.startObservingKeyboard()
    }
    
}

import AdvancedUIKit
import UIKit
