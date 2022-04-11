#if !os(macOS)
/// View+Designable adds supports for UI attributes.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 02/08/2019
@IBDesignable
public extension UIView {
    
    /// The border color of a view
    @IBInspectable
    var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get { layer.borderColor.map(UIColor.init(cgColor:)) }
    }
    
    /// The border width of a view
    @IBInspectable
    var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    /// The corner radious of a view
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue > 0 {
                clipsToBounds = true
            }
        }
        get { layer.cornerRadius }
    }
    
    /// The shadow inset
    @IBInspectable
    var shadowInset: CGSize {
        set { layer.shadowOffset = newValue }
        get { layer.shadowOffset }
    }
    
    /// The shadow opacity
    @IBInspectable
    var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { layer.shadowOpacity }
    }
    
    /// The shadow color
    @IBInspectable
    var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor }
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            } else {
                return nil
            }
        }
    }
    
    /// The width attribute
    @available(iOS, introduced: 10.0)
    var width: CGFloat? {
        get { getValue(of: widthAnchor) }
        set { setValue(newValue, of: widthAnchor) }
    }
    
    /// The height attribute
    @available(iOS, introduced: 10.0)
    var height: CGFloat? {
        get { getValue(of: heightAnchor) }
        set { setValue(newValue, of: heightAnchor) }
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
                                    constant: -edgeInsets.bottom).isActive = true
        }
        if edgeInsets.left != .invalidInset {
            leftAnchor.constraint(equalTo: superview.leftAnchor,
                                  constant: edgeInsets.left).isActive = true
        }
        if edgeInsets.right != .invalidInset {
            rightAnchor.constraint(equalTo: superview.rightAnchor,
                                   constant: -edgeInsets.right).isActive = true
        }
    }
    
    /// Pin the horizontal edges to its superview
    func pinHorizontalEdgesToSuperview() {
        pinEdgesToSuperview(with: .init(top: .invalidInset,
                                        left: 0,
                                        bottom: .invalidInset,
                                        right: 0))
    }
    
    /// Pin the horizontal edges to its superview
    func pinVerticalEdgesToSuperview() {
        pinEdgesToSuperview(with: .init(top: 0,
                                        left: .invalidInset,
                                        bottom: 0,
                                        right: .invalidInset))
    }
    
    /// Set a constraint value
    ///
    /// - Parameters:
    ///   - value: The value
    ///   - archor: The archor
    @available(iOS, introduced: 10.0)
    private func setValue(_ value: CGFloat?, of archor: NSLayoutDimension) {
        if let value = value,
            let constraint = constraints.first(where: {$0.firstAnchor == archor }) {
            constraint.isActive = true
            constraint.constant = value
        } else if let constraint = constraints.first(where: {$0.firstAnchor == archor }) {
            constraint.isActive = false
        } else if let value = value {
            translatesAutoresizingMaskIntoConstraints = false
            archor.constraint(equalToConstant: value).isActive = true
        }
    }
    
    /// Get the value
    ///
    /// - Parameter archor: The archor
    /// - Returns: The value
    @available(iOS, introduced: 10.0)
    private func getValue(of archor: NSLayoutDimension) -> CGFloat? {
        if let constraint = constraints.first(where: {$0.firstAnchor == archor}) {
            return constraint.isActive ? constraint.constant : nil
        } else {
            return nil
        }
    }
}

/// Constants
public extension CGFloat {
    
    /// Invalid edge inset
    static let invalidInset = CGFloat(Int.min)
}

import UIKit
#endif
