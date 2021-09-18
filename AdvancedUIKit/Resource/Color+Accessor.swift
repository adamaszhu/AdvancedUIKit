#if !os(macOS)
/// UIColor creates colors for convenience.
///
/// - author: Adamas
/// - version: 1.6.0
/// - date: 19/10/2019
public extension UIColor {
    
    /// Create a convenient color
    ///
    /// - Parameters:
    ///   - r: Red value
    ///   - g: Green value
    ///   - b: Blue value
    ///   - alpha: Alpha value
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / Self.maxValue,
                  green: g / Self.maxValue,
                  blue: b / Self.maxValue,
                  alpha: alpha)
    }
    
    /// Create a convenient color
    ///
    /// - Parameters:
    ///   - w: White value
    ///   - alpha: Alpha value
    convenience init(w: CGFloat, alpha: CGFloat = 1) {
        self.init(white: w / UIColor.maxValue, alpha: alpha)
    }
}

/// Constant
private extension UIColor {
    static let maxValue = CGFloat(255)
}

import UIKit
#endif
