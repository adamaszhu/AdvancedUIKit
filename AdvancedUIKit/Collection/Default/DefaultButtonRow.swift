/// DefaultButtonRow defines a default row that presents a button
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
public final class DefaultButtonRow: ButtonRow, DefaultButtonRowType, RowPresentable {
    public var view: UIView {
        let view = DefaultButtonView()
        view.configure(with: self)
        return view
    }
}

/// The type of a default button row
public protocol DefaultButtonRowType: ButtonRowType {}

import UIKit
