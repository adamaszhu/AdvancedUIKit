#if !os(macOS)
/// Anchor+Shortcut add the shortcut for creating a constraint.
///
/// - author: Adamas
/// - version: 1.6.7
/// - date: 30/06/2022
public extension NSLayoutAnchor {


    /// Create the constant between two anchor.
    /// - Parameters:
    ///   - distance: The distance between two anchors
    ///   - anchor: The second anchor
    /// - Returns: The generated constraint
    @discardableResult
    @objc func setDistance(_ distance: CGFloat,
                           to anchor: NSLayoutAnchor) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: distance)
        constraint.isActive = true
        return constraint
    }

    /// Create the constant between two anchor.
    /// - Parameter anchor: The second anchor
    /// - Returns: The generated constraint
    @discardableResult
    @objc func align(to anchor: NSLayoutAnchor) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor)
        constraint.isActive = true
        return constraint
    }
}

import UIKit
#endif
