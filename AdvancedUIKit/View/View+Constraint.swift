/// View+Constraint provides additional support to manipulate the constraint.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 09/06/2017
public extension UIView {
    
    /// The constraints related to the frame of the view. These constraints is usually added to superview.
    public var frameConstraints: Array<NSLayoutConstraint> {
        var frameConstraints = Array<NSLayoutConstraint>()
        if let superview = superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, firstItem == self {
                    frameConstraints.append(constraint)
                    continue
                }
                if let secondItem = constraint.secondItem as? UIView, secondItem == self {
                    frameConstraints.append(constraint)
                    continue
                }
            }
        }
        return frameConstraints
    }
    
    // TODO: Get self related constraints.
    
}

import UIKit
