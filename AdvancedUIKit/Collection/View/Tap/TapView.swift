/// TapView defines the basic of a custom tappable view
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class TapView<Row: TapRowType>: LabelView<Row> {

    open override func configure(with row: Row) {
        super.configure(with: row)
    }
}

import UIKit
