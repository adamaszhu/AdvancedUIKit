/// View+Gesture is used to add additional function to a uiview relating to the gesture function.
///
/// - author: Adamas
/// - version: 1.2.1
/// - date: 28/06/2018
@IBDesignable public extension UIView {
    
    /// The border color of a view
    @IBInspectable public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    /// The border width of a view
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /// The corner radious of a view
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}

import UIKit
