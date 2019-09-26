/// Button+Attribute contains additional support for a button
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/08/2019
public extension UIButton {
    
    /// Set and get the title of the button.
    var title: String? {
        set {
            titleLabel?.numberOfLines = 0
            setTitle(newValue, for: .normal)
        }
        get {
            return title(for: .normal)
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
            return titleLabel?.textAlignment
        }
    }
}

import UIKit
