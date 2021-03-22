/// TextField+Layout is used to contain dynamic content of a text field.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
public extension UITextField {
    
    /// Get the height of each line.
    var lineHeight: CGFloat {
        guard let font = font else {
            Logger.standard.logWarning(Self.fontEmptyWarning)
            return 0
        }
        return font.lineHeight
    }
}

/// Constants
private extension UITextField {
    
    /// System warning.
    private static let fontEmptyWarning = "The font is nil."
}

import AdvancedFoundation
import UIKit
