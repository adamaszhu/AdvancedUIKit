/// Label+Dynamic contains dynamic content of a label.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 22/04/2017
public extension UILabel {
    
    /// System warning.
    private static let textWarning = "The text is nil."
    
    /// Get the position of the last character.
    @objc var endPosition: CGPoint {
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
    @objc var lineHeight: CGFloat {
        return font.lineHeight
    }
    
    /// How many lines are presented.
    @objc var lineAmount: Int {
        guard let text = text else {
            Logger.standard.logWarning(UILabel.textWarning)
            return 0
        }
        return text.measuredLineAmount(with: font, in: self)
    }
    
    /// The actual height of the text.
    @objc var actualHeight: CGFloat {
        guard let text = text else {
            Logger.standard.logWarning(UILabel.textWarning)
            return 0
        }
        return text.measuredHeight(with: font, in: self)
    }
    
}

import AdvancedFoundation
import UIKit


