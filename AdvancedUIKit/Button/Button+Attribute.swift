#if !os(macOS)
/// Button+Attribute contains additional support for a button
///
/// - author: Adamas
/// - version: 1.6.0
/// - date: 08/08/2019
public extension UIButton {
    
    /// Set and get the title of the button.
    var title: String? {
        set {
            titleLabel?.numberOfLines = 0
            setTitle(newValue, for: .normal)
        }
        get {
            title(for: .normal)
        }
    }
    
    /// The title text alignment
    var textAlignment: NSTextAlignment? {
        set {
            if let textAlignment = newValue {
                titleLabel?.textAlignment = textAlignment
            }
        }
        get {
            titleLabel?.textAlignment
        }
    }
}

import UIKit
#endif
