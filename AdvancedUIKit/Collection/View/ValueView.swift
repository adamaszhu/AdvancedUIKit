/// ValueView defines a view that has both the title fields and a value
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
open class ValueView<Row: ValueRowType>: LabelView<Row> {

    /// The label to display the valie
    @IBOutlet private(set) var valueLabel: UILabel!

    open override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
        valueLabel.text = row.value
    }
}

import UIKit
