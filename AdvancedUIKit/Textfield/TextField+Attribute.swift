/**
 * TextField+Attribute provides additional support to access the attribute of the UITextField.
 * - author: Adamas
 * - version: 1.0.0
 * - author: 01/07/2017
 */
public extension UITextField {
    
    /**
     * Set the font color of the UITextField.
     */
    public var placeholderColor: UIColor {
        set {
            guard let placeholder = placeholder else {
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: newValue])
        }
        get {
            guard let placeholder = attributedPlaceholder else {
                return UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
            }
            var range = NSMakeRange(0, placeholder.length)
            guard let color = placeholder.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: &range) as? UIColor else {
                return UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
            }
            return color
        }
    }
    
}

import UIKit
