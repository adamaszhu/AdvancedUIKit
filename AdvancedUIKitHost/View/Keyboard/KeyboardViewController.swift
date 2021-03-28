final class KeyboardViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var firstnameText: UITextField!
    @IBOutlet private weak var lastnameText: UITextField!
    @IBOutlet private weak var mobileNumberText: UITextField!
    @IBOutlet private weak var addressLabel: UILabel!
    
    private lazy var keyboardHelper: KeyboardHelper = {
        let keyboardHelper = KeyboardHelper()
        keyboardHelper.delegate = self
        return keyboardHelper
    }()
    
    @IBAction func submit(_ sender: Any) {
        let firstname = firstnameText.text ?? .empty
        let lastname = lastnameText.text ?? .empty
        let mobileNumber = mobileNumberText.text ?? .empty
        let address = addressLabel.text ?? .empty
        let info = String(format: Self.submissionPattern, firstname, lastname, mobileNumber, address)
        messageHelper?.showInfo(info)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameText.activateUnderline(withNormal: Self.underlineColor, withHignlighted: Self.highlightedUnderlineColor)
        lastnameText.activateUnderline(withNormal: Self.underlineColor, withHignlighted: Self.highlightedUnderlineColor)
        mobileNumberText.activateUnderline(withNormal: Self.underlineColor, withHignlighted: Self.highlightedUnderlineColor)
        keyboardHelper.rootView = view
        keyboardHelper.inputViews = [searchBar, firstnameText, lastnameText, mobileNumberText]
        keyboardHelper.startObservingKeyboard()
    }
}

extension KeyboardViewController: KeyboardHelperDelegate {
    
    func keyboardHelperDidConfirmInput(_ keyboardHelper: KeyboardHelper) {
        submit(self)
    }
    
    func keyboardHelper(_ keyboardHelper: KeyboardHelper, didEditOn view: UIView) {
        if view == searchBar {
            addressLabel.text = searchBar.text
        }
    }
}

private extension KeyboardViewController {
    static let highlightedUnderlineColor = UIColor(red: 125/255, green: 182/255, blue: 216/255, alpha: 1)
    static let underlineColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
    static let submissionPattern = "Firstname: %@\nLastname: %@\nMobile: %@\nAddress: %@"
}

import AdvancedUIKit
import AdvancedFoundation
import UIKit
