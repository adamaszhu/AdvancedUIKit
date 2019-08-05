/// View+Constraint provides additional support to manipulate the constraint.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/06/2019
public extension UIView {
    
    /// The constraints related to the frame of the view. These constraints is usually added to superview.
    var frameConstraints: [NSLayoutConstraint] {
        guard let superview = superview else  {
            return []
        }
        return superview.constraints.filter {
            if let firstItem = $0.firstItem as? UIView, firstItem == self {
                return true
            } else if let secondItem = $0.secondItem as? UIView, secondItem == self {
                return true
            } else {
                return false
            }
        }
    }
}

import UIKit
