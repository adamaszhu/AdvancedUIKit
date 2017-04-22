/**
 * Label+Dynamic contains dynamic content of a label.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/04/2017
 */
public extension UILabel {
    
    /**
     * Get the position of the last character.
     */
    public var endPosition: CGPoint {
        if lineAmount == 0 {
            return frame.origin
        }
        // COMMENT: If lastLine is nil, then the logic should be fixed.
        let lastLine = text!.components(separatedBy: CharacterSet.newlines).last!
        let size = NSString(string: lastLine).size(attributes: [NSFontAttributeName: font])
        let lastLineLength = CGFloat(Int(size.width) % Int(frame.width))
        let offsetX = lastLineLength == 0 ? frame.width : lastLineLength
        let offsetY = frame.height - lineHeight
        return CGPoint(x: frame.origin.x + offsetX, y: frame.origin.y + offsetY)
    }
    
    /**
     * Get the height of each line.
     */
    public var lineHeight: CGFloat {
        return font.lineHeight
    }
    
    /**
     * How many lines are presented.
     */
    public var lineAmount: Int {
        guard let text = text else {
            return 0
        }
        return text.measureLineAmount(withFont: font, inView: self)
    }
    
}

import UIKit


