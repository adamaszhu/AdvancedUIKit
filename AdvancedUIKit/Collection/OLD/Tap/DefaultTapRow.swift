/// DefaultTapRow defines the row of a tap view that can be used directly
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public final class DefaultTapRow: TapRow, RowPresentable {

    public var view: UIView {
        let view = DefaultTapView()
        view.configure(with: self)
        return view
    }
}

import UIKit
