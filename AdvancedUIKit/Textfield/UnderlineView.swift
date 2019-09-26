/// UnderlineView records the underline for a text field.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
final class UnderlineView: UIView {
    
    /// The normal color of the underline.
    var color: UIColor = .clear
    
    /// The highlighted color of the underline.
    var highlightedColor: UIColor = .clear
    
    /// Whether the underline is under highlighted status or not.
    var isHighlighted: Bool {
        set {
            backgroundColor = newValue ? highlightedColor : color
        }
        get {
            return backgroundColor == highlightedColor
        }
    }
}

import AdvancedFoundation
import UIKit
