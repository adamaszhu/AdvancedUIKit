/// TapView defines the basic of a custom tappable view
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class TapView<Row: TapRowType>: LabelView<Row> {

    open override func configure(with row: Row) {
        super.configure(with: row)
    }

    /// Action to trigger when the view is tapped.
    /// - Parameter :  The view that triggers the event
    @IBAction func tap(_: Any) {
        row?.didTapAction?()
    }
}

import UIKit
