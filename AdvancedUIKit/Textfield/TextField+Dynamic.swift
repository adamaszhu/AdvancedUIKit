/**
 * TextField+Dynamic is used to contain dynamic content of a text field.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 01/06/2017
 */
public extension UITextField {
    
    /**
     * Get the height of each line.
     */
    public var lineHeight: CGFloat {
        guard let font = font else {
            return 0
        }
        return font.lineHeight
    }
    
    /**
     * How many lines are presented.
     */
    public var lineAmount: Int {
        guard let text = text else {
            return 0
        }
        guard let font = font else {
            return 0
        }
        return text.measureLineAmount(withFont: font, inView: self)
    }
    
    /**
     * The actual height of the text.
     */
    public var actualHeight: CGFloat {
        // COMMENT: If it will be changed to multiple line in the future, a default line space around 5 should be considered.
        return lineHeight
    }
    
}

import UIKit
