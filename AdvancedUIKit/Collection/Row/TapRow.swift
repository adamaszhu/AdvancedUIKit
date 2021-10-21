/// TapRow presents a single tappable item in the collection.
///
/// - version: 1.8.0
/// - date: 07/10/21
/// - author: Adamas
open class TapRow: LabelRow, TapRowType {
    
    public var didTapAction: (() -> Void)?
    public var isEnabled: Bool = true
}

/// The interface of a tappable row
public protocol TapRowType: LabelRowType {

    /// Whether or not the row can be tapped
    var isEnabled: Bool { get set }

    /// The action to be triggered by the tapping action
    var didTapAction: (() -> Void)? { get set }
}

import UIKit
