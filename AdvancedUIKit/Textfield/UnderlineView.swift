/// UnderlineView records the underline for a text field.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
final class UnderlineView: UIView {
    
    /// The normal color of the underline.
    var color: UIColor
    
    /// The highlighted color of the underline.
    var highlightedColor: UIColor
    
    /// Whether the underline is under highlighted status or not.
    var isHighlighted: Bool {
        set {
            backgroundColor = newValue ? highlightedColor : color
        }
        get {
            return backgroundColor == highlightedColor
        }
    }
    
    override init(frame: CGRect) {
        color = .clear
        highlightedColor = .clear
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.log(error: UnderlineView.initError)
        return nil
    }
    
}

import UIKit
