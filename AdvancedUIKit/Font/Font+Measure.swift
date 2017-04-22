/**
 * Font+Measure add additional support for the font to measure texts on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/04/2017
 */

extension UIFont {
    
    /**
     * Measure how many lines the context based on the font.
     */
    func measureLineAmount(ofContext context: String, inView view: UIView) -> Int {
        if view.frame.width == 0 {
            return 0
        }
        if context.isEmpty {
            return 1
        }
        let viewWidth = view.frame.width
        var lineAmount = 0
        let lines = context.components(separatedBy: CharacterSet.newlines)
        for line in lines {
            let size = NSString(string: line).size(attributes: [NSFontAttributeName: self])
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
