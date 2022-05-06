/// View defines the basic of a custom view that has a sub title
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class LabelView<Row: LabelRowType>: View<Row> {
    /// The subtitle label.
    @IBOutlet public private(set) var subtitleLabel: UILabel?

    open override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
        subtitleLabel?.text = row.subtitle
    }
}

import UIKit
