/// View+Constraint provides additional support to manipulate the constraint.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 09/06/2017
public extension UIView {
    
    /// The constraints related to the frame of the view. These constraints is usually added to superview.
    @objc var frameConstraints: [NSLayoutConstraint] {
        var frameConstraints = [NSLayoutConstraint]()
        guard let superview = superview else  {
            return frameConstraints
        }
        superview.constraints.forEach {
            if let firstItem = $0.firstItem as? UIView, firstItem == self {
                frameConstraints.append($0)
            } else if let secondItem = $0.secondItem as? UIView, secondItem == self {
                frameConstraints.append($0)
            }
        }
        return frameConstraints
    }
    
}

import UIKit
