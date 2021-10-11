/// ButtonRow presents a single button item in the collection.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class ButtonRow: Row, ButtonRowType {

    public var didClickAction: (() -> Void)?
    
    public var isEnabled: Bool = true {
        didSet {
            reloadAction?()
        }
    }
}

/// The interface of a tappable row
public protocol ButtonRowType: RowType {

    /// Whether or not the button is tappable
    var isEnabled: Bool { get set }

    /// The action to be triggered by the tapping action
    var didClickAction: (() -> Void)? { get set }
}

import UIKit
