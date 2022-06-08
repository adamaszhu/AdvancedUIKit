#if !os(macOS)
/// The alpha value of different states
///
/// - author: Adamas
/// - version: 1.8.0
/// - date: 24/05/2022
public extension CGFloat {
    static let visible: CGFloat = 1
    static let disabled: CGFloat = 0.5
    static let hidden: CGFloat = 0
}

import UIKit
import CoreGraphics
#endif
