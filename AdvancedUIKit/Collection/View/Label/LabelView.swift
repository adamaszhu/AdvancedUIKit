/// View defines the basic of a custom view that has a sub title
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class LabelView<Row: LabelRowType>: View<Row> {

    /// The subtitle label.
    @IBOutlet private(set) var subtitleLabel: UILabel?

    open override func configure(with row: Row) {
        super.configure(with: row)
        subtitleLabel?.text = row.subtitle
    }
}

import UIKit
