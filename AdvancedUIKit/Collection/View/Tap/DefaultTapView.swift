/// DefaultTapView defines a label view that can be used directly
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public final class DefaultTapView: TapView<DefaultTapRow> {}

/// Presentation of the default tap view
extension DefaultTapRow: RowPresentable {

    public var view: UIView {
        let view = DefaultTapView()
        view.configure(with: self)
        return view
    }
}

import UIKit
