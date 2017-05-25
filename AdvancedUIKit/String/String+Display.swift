/**
 * String+Display add additional support for displaying a string on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/04/2017
 */

extension String {
    
    /**
     * Get the width of a string with a specific font.
     * - parameter font: The font.
     * - returns: The width.
     */
    func measureWidth(withFont font: UIFont) -> CGFloat {
        return NSString(string: self).size(attributes: [NSFontAttributeName: font]).width
    }
    
    /**
     * Get the actual line amount displayed on the screen.
     * - parameter font: The font that is applied.
     * - parameter view: The view that text is in.
     * - returns: The actual line amount displayed on the view.
     */
    func measureLineAmount(withFont font: UIFont, inView view: UIView) -> Int {
        return measureLines(withFont: font, inView: view).count
    }
    
    /**
     * Get the actual lines displayed on the screen.
     * - parameter font: The font that is applied.
     * - parameter view: The view that text is in.
     * - returns: The actual lines displayed on the view.
     */
    func measureLines(withFont font: UIFont, inView view: UIView) -> Array<String> {
        if view.frame.width == 0 {
            return []
        }
        var displayedLines = Array<String>()
        let lines = components(separatedBy: CharacterSet.newlines)
        for line in lines {
            for displayedLine in line.measureLine(withFont: font, inView: view) {
                displayedLines.append(displayedLine)
            }
        }
        return displayedLines
    }
    
    /**
     * Measure lines displayed on the screen for a single line according to the font and view contains it.
     * - parameter font: The font that is applied.
     * - parameter view: The view that text is in.
     * - returns: The actual line amount displayed on the view.
     */
    private func measureLine(withFont font: UIFont, inView view: UIView) -> Array<String> {
        if isEmpty {
            return [""]
        }
        var lines = Array<String>()
        var remainLine = self
        while !remainLine.isEmpty {
            // COMMENT: Extract a line from the beginning of the remainLine. For better performance, words seperating strategy is considered prior to character seperating strategy.
            // COMMENT: Extract a line containing several words from the beginning of the remainLine.
            var words = remainLine.components(separatedBy: CharacterSet.whitespaces)
            var width = words.joined(separator: " ").measureWidth(withFont: font)
            while (width > view.frame.width) && (words.count > 1) {
                words.removeLast()
                width = words.joined(separator: " ").measureWidth(withFont: font)
            }
            if width <= view.frame.width {
                let line = words.joined(separator: " ")
                lines.append(line)
                // COMMENT: remainLine must have the line extracted.
                remainLine = remainLine.removePrefix(line)!
                // COMMENT: If the remainLine is not empty, remove the space between current line and the next line.
                remainLine = remainLine.removePrefix(" ") ?? remainLine
                continue
            }
            // COMMENT: Extra a line from a extra long word from the beginning of the remainLine. Only one word is left.
            var word = words.first!
            width = word.measureWidth(withFont: font)
            while width > view.frame.width {
                word = word.substring(to: word.index(word.endIndex, offsetBy: -1))
                width = word.measureWidth(withFont: font)
            }
            lines.append(word)
            // COMMENT: remainLine must have the line extracted.
            remainLine = remainLine.removePrefix(word)!
        }
        return lines
    }
    
}

import UIKit
