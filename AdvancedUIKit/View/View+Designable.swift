/// View+Designable adds supports for UI attributes.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 02/08/2019
@IBDesignable public extension UIView {
    
    /// The border color of a view
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            return layer.borderColor.map(UIColor.init(cgColor:))
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
            if newValue > 0 {
                clipsToBounds = true
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    /// Pin the edge to its superview
    ///
    /// - Parameter edgeInsets: The edge insets. If one inset is not necessary to be settled, set it to be .invalidInset
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

/// Constants
public extension CGFloat {
    
    /// Invalid edge inset
    static let invalidInset = CGFloat(Int.min)
}

import UIKit
