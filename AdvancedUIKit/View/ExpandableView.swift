#if !os(macOS)
/// ExpandableView defines what an expandable view should do.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
protocol ExpandableView: class {
    
    /// The original superview.
    var originalSuperview: UIView! { get set }
    
    /// The original z Index.
    var originalZIndex: Int! { get set }
    
    /// The origin frame in origin view.
    var originalFrame: CGRect! { get set }
    
    /// The original frame related constraints on the superview.
    var originalFrameConstraints: [NSLayoutConstraint]! { get set }
    
    /// The original constraints.
    var originalConstraints: [NSLayoutConstraint]! { get set }
    
    /// Whether the view can be expanded or not.
    var isExpandable: Bool { get set }
    
    /// Whether the view is expanded or not.
    var isExpanded: Bool { get }
    
    /// Expand the view.
    func expand()
    
    /// Collapse the view.
    func collapse()
}

/// Constants
extension ExpandableView {
    
    /// System error.
    static var superviewError: String { "The superview is nil." }
    static var windowError: String { "The window is nil." }
    
    /// System warning.
    static var expandingWarning: String { "The view cannot be expanded." }
    static var collapsingWarning: String { "The view cannot be collapsed." }
}

import UIKit
#endif
