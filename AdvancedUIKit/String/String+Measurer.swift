/// String+Measurer add additional support for displaying a string on the screen.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 22/04/2017
extension String {
    
    /// System warning.
    private static let viewWidthWarning = "The width of the view is 0."
    
    /// Get the width of a string with a specific font.
    ///
    /// - Parameter font: The font.
    /// - Returns: The width.
    func measuredWidth(withFont font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedStringKey.font: font]).width
    }
    
    /// Get the width of a string with a specific font.
    ///
    /// - Parameter font: The font.
    /// - Returns: The height.
    func measuredHeight(withFont font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedStringKey.font: font]).height
    }
    
    /// Get the actual line amount displayed on the screen.
    ///
    /// - Parameters:
    ///   - font: The font that is applied.
    ///   - view: The view that text is in.
    /// - Returns: The actual line amount displayed on the view.
    func measuredLineAmount(withFont font: UIFont, inView view: UIView) -> Int {
        let height = measuredHeight(withFont: font, inView: view)
        return Int(height / font.lineHeight)
    }
    
    /// Get the actual height of the string displayed on the screen.
    ///
    /// - Parameters:
    ///   - font: The font that is applied.
    ///   - view: The view that text is in.
    /// - Returns: The actual height displayed on the view.
    func measuredHeight(withFont font: UIFont, inView view: UIView) -> CGFloat {
        let maxBounds = CGSize(width: view.frame.width, height: .greatestFiniteMagnitude)
        let bounds = self.boundingRect(with: maxBounds, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return bounds.height
    }
    
    /// Get the actual lines displayed on the screen.
    ///
    /// - Parameters:
    ///   - font: The font that is applied.
    ///   - view: The view that text is in.
    /// - Returns: The actual lines displayed on the view.
    func measuredLines(withFont font: UIFont, inView view: UIView) -> [String] {
        guard view.frame.width != 0 else {
            Logger.standard.logWarning(String.viewWidthWarning)
            return []
        }
        var displayedLines = [String]()
        let lines = components(separatedBy: CharacterSet.newlines)
        lines.forEach {
            displayedLines = displayedLines + $0.measureLine(withFont: font, inView: view)
        }
        return displayedLines
    }
    
    /// Measure lines displayed on the screen for a single line according to the font and view contains it.
    /// 
    /// - Parameters:
    ///   - font: The font that is applied.
    ///   - view: The view that text is in.
    /// - Returns: The actual line amount displayed on the view.
    private func measureLine(withFont font: UIFont, inView view: UIView) -> [String] {
        guard !isEmpty else {
            return [.empty]
        }
        var lines = [String]()
        var remainLine = self
        while !remainLine.isEmpty {
            // Extract a line from the beginning of the remainLine. For better performance, words seperating strategy is considered prior to character seperating strategy.
            // Extract a line containing several words from the beginning of the remainLine.
            var words = remainLine.components(separatedBy: .whitespaces)
            var width = words.joined(separator: .space).measuredWidth(withFont: font)
            while width > view.frame.width, words.count > 1 {
                words.removeLast()
                width = words.joined(separator: .space).measuredWidth(withFont: font)
            }
            if width <= view.frame.width {
                let line = words.joined(separator: .space)
                lines.append(line)
                // remainLine must have the line extracted.
                remainLine.remove(prefix: line)
                // If the remainLine is not empty, remove the space between current line and the next line.
                remainLine.remove(prefix: .space)
                continue
            }
            // Extra a line from a extra long word from the beginning of the remainLine. Only one word is left.
            var word = words.first ?? .empty
            while width > view.frame.width {
                word = .init(word[..<word.index(word.endIndex, offsetBy: -1)])
                width = word.measuredWidth(withFont: font)
            }
            lines.append(word)
            // remainLine must have the line extracted.
            remainLine.remove(prefix: word)
        }
        return lines
    }
    
}

import UIKit
