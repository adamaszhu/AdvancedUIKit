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

    /// The top space to its superview
    @available(iOS, introduced: 10.0)
    var top: CGFloat? {
        get {
            guard let superview = superview else {
                return nil
            }
            return getValue(between: topAnchor, and: superview.topAnchor)
        }
        set {
            guard let superview = superview else {
                return
            }
            setValue(newValue, between: topAnchor, and: superview.topAnchor )
        }
    }

    /// The left space to its superview
    @available(iOS, introduced: 10.0)
    var left: CGFloat? {
        get {
            guard let superview = superview else {
                return nil
            }
            return getValue(between: leftAnchor, and: superview.leftAnchor)
        }
        set {
            guard let superview = superview else {
                return
            }
            setValue(newValue, between: leftAnchor, and: superview.leftAnchor)
        }
    }

    /// The right space to its superview
    @available(iOS, introduced: 10.0)
    var right: CGFloat? {
        get {
            guard let superview = superview else {
                return nil
            }
            return getValue(between: rightAnchor, and: superview.rightAnchor)
        }
        set {
            guard let superview = superview else {
                return
            }
            setValue(newValue, between: rightAnchor, and: superview.rightAnchor)
        }
    }

    /// The bottom space to its superview
    @available(iOS, introduced: 10.0)
    var bottom: CGFloat? {
        get {
            guard let superview = superview else {
                return nil
            }
            return getValue(between: bottomAnchor, and: superview.bottomAnchor)
        }
        set {
            guard let superview = superview else {
                return
            }
            setValue(newValue, between: bottomAnchor, and: superview.bottomAnchor)
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
            if #available(iOS 10.0, *) {
                top = edgeInsets.top
            } else {
                topAnchor.constraint(equalTo: superview.topAnchor,
                                     constant: edgeInsets.top).isActive = true
            }
        }
        if edgeInsets.bottom != .invalidInset {
            if #available(iOS 10.0, *) {
                bottom = edgeInsets.bottom
            } else {
                bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                        constant: -edgeInsets.bottom).isActive = true
            }
        }
        if edgeInsets.left != .invalidInset {
            if #available(iOS 10.0, *) {
                left = edgeInsets.left
            } else {
                leftAnchor.constraint(equalTo: superview.leftAnchor,
                                      constant: edgeInsets.left).isActive = true
            }
        }
        if edgeInsets.right != .invalidInset {
            if #available(iOS 10.0, *) {
                right = edgeInsets.right
            } else {
                rightAnchor.constraint(equalTo: superview.rightAnchor,
                                       constant: -edgeInsets.right).isActive = true
            }
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
    
    /// Set a self owned constraint value, like height and width.
    ///
    /// - Parameters:
    ///   - value: The value
    ///   - archor: The archor
    @available(iOS, introduced: 10.0)
    private func setValue(_ value: CGFloat?, of archor: NSLayoutDimension) {
        let constraint = constraints.first { $0.firstAnchor == archor }
        if let value = value,
           let constraint = constraint {
            constraint.isActive = true
            constraint.constant = value
        } else if let constraint = constraint {
            constraint.isActive = false
        } else if let value = value {
            translatesAutoresizingMaskIntoConstraints = false
            archor.constraint(equalToConstant: value).isActive = true
        }
    }
    
    /// Get a self owned constraint value, like height and width.
    ///
    /// - Parameter archor: The archor
    /// - Returns: The value
    @available(iOS, introduced: 10.0)
    private func getValue(of archor: NSLayoutDimension) -> CGFloat? {
        let constraint = constraints.first { $0.firstAnchor == archor }
        return constraint?.isActive == true ? constraint?.constant : nil
    }

    /// Set the constraint value between two archors.
    ///
    /// - Parameters:
    ///   - value: The value
    ///   - firstArchor: The first archor
    ///   - secondArchor: The second archor
    @available(iOS, introduced: 10.0)
    private func setValue<Archor>(_ value: CGFloat?, between firstArchor: NSLayoutAnchor<Archor>, and secondArchor: NSLayoutAnchor<Archor>) {
        let constraint = superview?
            .constraints
            .first { ($0.firstAnchor == firstArchor && $0.secondAnchor == secondArchor)
                || ($0.secondAnchor == firstArchor && $0.firstAnchor == secondArchor) }
        if let value = value,
            let constraint = constraint {
            constraint.isActive = true
            constraint.constant = value
        } else if let constraint = constraint {
            constraint.isActive = false
        } else if let value = value {
            translatesAutoresizingMaskIntoConstraints = false
            firstArchor.constraint(equalTo: secondArchor,
                                   constant: value).isActive = true
        }
    }

    /// Get the constraint value between two archors.
    ///
    /// - Parameters
    ///   - firstArchor: The first archor
    ///   - secondArchor: The second archor
    /// - Returns: The value
    @available(iOS, introduced: 10.0)
    private func getValue<Archor>(between firstArchor: NSLayoutAnchor<Archor>, and secondArchor: NSLayoutAnchor<Archor>) -> CGFloat? {
        let constraint = superview?
            .constraints
            .first { ($0.firstAnchor == firstArchor && $0.secondAnchor == secondArchor)
                || ($0.secondAnchor == firstArchor && $0.firstAnchor == secondArchor) }
        return constraint?.isActive == true ? constraint?.constant : nil
    }
}

/// Constants
public extension CGFloat {
    
    /// Invalid edge inset
    static let invalidInset = CGFloat(Int.min)
}

import UIKit
#endif
