/// TextField+Dynamic is used to contain dynamic content of a text field.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 01/06/2017
public extension UITextField {
    
    /// System warning.
    private static let fontEmptyWarning = "The font is nil."
    private static let textEmptyWarning = "The text is nil."
    
    /// Get the height of each line.
    public var lineHeight: CGFloat {
        guard let font = font else {
            Logger.standard.log(warning: UITextField.fontEmptyWarning)
            return 0
        }
        return font.lineHeight
    }
    
}

import UIKit
