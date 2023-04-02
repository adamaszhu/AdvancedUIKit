#if !os(macOS)
/// TextField+Attribute provides additional support to access the attribute of the UITextField.
/// 
/// - author: Adamas
/// - version: 1.5.0
/// - author: 15/08/2018
public extension UITextField {
    
    /// Set the font color of the UITextField.
    var placeholderColor: UIColor {
        set {
            guard let placeholder = placeholder else {
                Logger.standard.logWarning(Self.placeholderEmptyWarning)
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholder,
                                                       attributes: [.foregroundColor: newValue])
        }
        get {
            guard let placeholder = attributedPlaceholder else {
                Logger.standard.logWarning(Self.placeholderEmptyWarning)
                return Self.defaultPlaceholderColor
            }
            var range = NSMakeRange(0, placeholder.length)
            guard let color = placeholder.attribute(.foregroundColor, at: 0,
                                                    effectiveRange: &range) as? UIColor else {
                Logger.standard.logWarning(Self.placeholderColorWarning)
                return Self.defaultPlaceholderColor
            }
            return color
        }
    }
}

/// Constants
private extension UITextField {
    
    /// System warning.
    static let placeholderEmptyWarning = "The placeholder is nil."
    static let placeholderColorWarning = "The placeholder doesn't have a color."
    
    /// Default values
    static let defaultPlaceholderColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
}

import AdvancedFoundation
import UIKit
#endif
