/// DefaultLabelRow defines the row of a label view that can be used directly
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public final class DefaultLabelRow: LabelRow, RowPresentable {

    public var view: UIView {
        let view = DefaultLabelView()
        view.configure(with: self)
        return view
    }
}

import UIKit
