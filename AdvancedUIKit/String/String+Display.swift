/**
 * String+Display add additional support for displaying a string on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/04/2017
 */

extension String {
    
    /**
     * Get the actual lines displayed on the screen.
     * - parameter font: The font that is applied.
     * - parameter view: The view that text is in.
     * - returns: The actual lines displayed on the view.
     */
    func measureLineAmount(withFont font: UIFont, inView view: UIView) -> Int {
        if view.frame.width == 0 {
            return 0
        }
        if isEmpty {
            return 1
        }
        let viewWidth = view.frame.width
        var lineAmount = 0
        let lines = components(separatedBy: CharacterSet.newlines)
        for line in lines {
            let size = NSString(string: line).size(attributes: [NSFontAttributeName: font])
            if size.width == 0 {
                // COMMENT: An empty line.
                lineAmount = lineAmount + 1
                continue
            }
            lineAmount = lineAmount + Int(size.width / viewWidth)
            // COMMENT: Whether the last line is a full line or half line.
            let isLastLineFilled = Int(size.width) % Int(viewWidth) == 0
            lineAmount = lineAmount + (isLastLineFilled ? 0 : 1)
        }
        return lineAmount
    }
    
}

import UIKit
