/// TextField+Attribute provides additional support to access the attribute of the UITextField.
/// 
/// - author: Adamas
/// - version: 1.0.0
/// - author: 01/07/2017
public extension UITextField {
    
    /// System warning.
    private static let placeholderEmptyWarning = "The placeholder is nil."
    private static let placeholderColorWarning = "The placeholder doesn't have a color."
    
    /// Set the font color of the UITextField.
    @objc public var placeholderColor: UIColor {
        set {
            guard let placeholder = placeholder else {
                Logger.standard.log(warning: UITextField.placeholderEmptyWarning)
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: newValue])
        }
        get {
            guard let placeholder = attributedPlaceholder else {
                Logger.standard.log(warning: UITextField.placeholderEmptyWarning)
                return .init(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
            }
            var range = NSMakeRange(0, placeholder.length)
            guard let color = placeholder.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: &range) as? UIColor else {
                Logger.standard.log(warning: UITextField.placeholderColorWarning)
                return .init(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
            }
            return color
        }
    }
    
}

import UIKit
