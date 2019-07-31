/// View+Gesture is used to add additional function to a uiview relating to the gesture function.
///
/// - author: Adamas
/// - version: 1.2.1
/// - date: 28/06/2018
@IBDesignable public extension UIView {
    
    /// The border color of a view
    @IBInspectable var borderColor: UIColor? {
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
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /// The corner radious of a view
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    /// Pin the edge to its superview
    ///
    /// - Parameter edgeInsets: The edge insets. If one inset is not necessary to be settled, set it to be .invalidInset
    @available(iOS 9.0, *)
    func pinEdgesToSuperview(with edgeInsets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        if edgeInsets.top != .invalidInset {
            topAnchor.constraint(equalTo: superview.topAnchor,
                                 constant: edgeInsets.top).isActive = true
        }
        if edgeInsets.bottom != .invalidInset {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                    constant: edgeInsets.bottom).isActive = true
        }
        if edgeInsets.left != .invalidInset {
            leftAnchor.constraint(equalTo: superview.leftAnchor,
                                  constant: edgeInsets.left).isActive = true
        }
        if edgeInsets.right != .invalidInset {
            rightAnchor.constraint(equalTo: superview.rightAnchor,
                                   constant: edgeInsets.right).isActive = true
        }
    }
}

public extension CGFloat {
    static let invalidInset = CGFloat(Int.min)
}

import UIKit
