/// Convertion between different image concepts
///
/// - author: Adamas
/// - date: 16/09/2022
/// - version: 1.9.8
public extension CIImage {

    /// CoreImage has a different coordinator system from what UIKit has. This is used to convert a rect from the UIKit coordinator system into the CoreImage one.
    /// CoreImage coordinator starts at the bottom-left corner.
    /// UIKit coordinator starts at the top-left corner.
    /// REF: https://nacho4d-nacho4d.blogspot.com/2012/03/coreimage-and-uikit-coordinates.html
    ///
    /// - Parameters:
    ///   - rect: The rect in the UIKit system
    ///   - superRect: The rect of the superview in the UIKit system, origin will be ignored
    /// - Returns: A coverted rect in the CoreImage coordinator system
    static func ciRect(for rect: CGRect, in superRect: CGRect) -> CGRect {
        CGRect(x: rect.minX,
               y: superRect.height - rect.minY - rect.height,
               width: rect.width,
               height: rect.height)
    }
}

import UIKit
