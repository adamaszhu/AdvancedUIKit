/// Button+Attribute contains additional support for a button
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 31/05/2017
public extension UIButton {
    
    /// Set and get the title of the button.
    @objc var title: String? {
        set {
            titleLabel?.numberOfLines = 0
            titleLabel?.textAlignment = .center
            setTitle(newValue, for: .normal)
        }
        get {
            return titleLabel?.text
        }
    }
    
}

import UIKit


