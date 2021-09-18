#if !os(macOS)
/// Label+Dynamic contains dynamic content of a label.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
public extension UILabel {
    
    /// Get the position of the last character.
    var endPosition: CGPoint {
        guard lineAmount != 0 else {
            return frame.origin
        }
        // If lastLine is nil, then the logic should be fixed.
        let lastLine = text!.measuredLines(with: font, in: self).last!
        let lastLineLength = lastLine.measuredWidth(with: font)
        let offsetX = lastLineLength
        let offsetY = frame.height - lineHeight
        return CGPoint(x: frame.origin.x + offsetX, y: frame.origin.y + offsetY)
    }
    
    /// Get the height of each line.
    var lineHeight: CGFloat { font.lineHeight }
    
    /// How many lines are presented.
    var lineAmount: Int {
        guard let text = text else {
            Logger.standard.logWarning(Self.textWarning)
            return 0
        }
        return text.measuredLineAmount(with: font, in: self)
    }
    
    /// The actual height of the text.
    var actualHeight: CGFloat {
        guard let text = text else {
            Logger.standard.logWarning(Self.textWarning)
            return 0
        }
        return text.measuredHeight(with: font, in: self)
    }
}

/// Constants
private extension UILabel {
    
    /// System warning.
    static let textWarning = "The text is nil."
}

import AdvancedFoundation
import UIKit
#endif
