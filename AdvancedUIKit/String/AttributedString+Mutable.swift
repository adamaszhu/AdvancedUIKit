#if !os(macOS)
/// AttributedString+Mutable provides the ability to modify an attributed string.
///
/// - author: Adamas
/// - version: 1.9.0
/// - date: 29/04/2022
public extension NSAttributedString {

    /// Append a new attributed string to the end of the current one.
    ///
    /// - Parameter string: The new attributed string.
    /// - Returns: The combined string
    func appending(_ string: NSAttributedString) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self)
        mutableString.append(string)
        return mutableString
    }

    /// Add an underline to a substring.
    ///
    /// - Parameter substring: The substring that should have an underline. Nil will apply the line to the whole string.
    /// - Returns: A string with an underline.
    func addingUnderline(toFirstSubstring substring: String? = nil) -> NSAttributedString {
        addingAttributes(.underlineStyle,
                         value: NSUnderlineStyle.single.rawValue,
                         toFirstSubstring: substring)
    }

    /// Add linking function to a substring.
    ///
    /// - Parameters:
    ///   - link: The url link to be applied.
    ///   - substring: The clickable substring. Nil will apply the link to the whole string.
    /// - Returns: A string with a link.
    func addingLink(_ link: String,
                    toFirstSubstring substring: String? = nil) -> NSAttributedString {
        addingAttributes(.link, value: link, toFirstSubstring: substring)
    }

    /// Change the font of a substring.
    ///
    /// - Parameters:
    ///   - font: The new font to be applied.
    ///   - substring: The substring that should be changed. Nil will apply the new font to the whole string.
    /// - Returns: A string with part of the string applying the new font.
    func changingFont(_ font: UIFont, ofFirstSubstring substring: String? = nil) -> NSAttributedString {
        addingAttributes(.font,
                         value: font,
                         toFirstSubstring: substring)
    }

    /// Strike cross part of the string.
    ///
    /// - Parameter substring: The substring that should be crossed. Nil will apply the effect to the whole string.
    /// - Returns: A string with part of it being crossed.
    func addingStrike(ofFirstSubstring substring: String? = nil) -> NSAttributedString {
        addingAttributes(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, toFirstSubstring: substring)
    }

    /// Change the color of a sub string.
    ///
    /// - Parameters:
    ///   - color: The new color to apply.
    ///   - substring: The substring that should apply the new color. Nil will apply the color to the whole string.
    /// - Returns: A new string with part of it using the new color.
    func changingColor(_ color: UIColor, ofFirstSubstring substring: String? = nil) -> NSAttributedString {
        addingAttributes(.foregroundColor,
                         value: color,
                         toFirstSubstring: substring)
    }

    /// Add an new attribute to part of the string
    ///
    /// - Parameters:
    ///   - name: The name of the new attribute.
    ///   - value: The value of the new attribute.
    ///   - substring: The substring that should apply the new attribute. Nil will apply the attribute to the whole string.
    /// - Returns: A new string with part of it using the new attribute.
    private func addingAttributes(_ name: NSAttributedString.Key,
                                  value: Any,
                                  toFirstSubstring substring: String?) -> NSAttributedString {
        let string = substring ?? self.string
        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
        guard let stringRange = self.string.range(of: string) else {
            return self
        }
        mutableAttributedString.addAttribute(name,
                                             value: value,
                                             range: NSRange(stringRange, in: self.string))
        return mutableAttributedString
    }
}

import UIKit
#endif
