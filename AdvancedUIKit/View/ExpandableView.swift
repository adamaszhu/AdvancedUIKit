/// ExpandableView defines what an expandable view should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 19/06/2017
protocol ExpandableView: class {
    
    /// The original superview.
    var originalSuperview: UIView! { get set }
    
    /// The original z Index.
    var originalZIndex: Int! { get set }
    
    /// The origin frame in origin view.
    var originalFrame: CGRect! { get set }
    
    /// The original frame related constraints on the superview.
    var originalFrameConstraints: Array<NSLayoutConstraint>! { get set }
    
    /// The original constraints.
    var originalConstraints: Array<NSLayoutConstraint>! { get set }
    
    /// Whether the view can be expanded or not.
    var isExpandable: Bool { get set }
    
    /// Whether the view is expanded or not.
    var isExpanded: Bool { get }
    
    /// Expand the view.
    func expand()
    
    /// Collapse the view.
    func collapse()
    
}

import UIKit
