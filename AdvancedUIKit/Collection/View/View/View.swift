/// View defines the basic of a custom view
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class View<Row: RowType>: UIView {

    /// The title label on the view
    @IBOutlet public private(set) var titleLabel: UILabel?

    /// The main image on the view
    @IBOutlet public private(set) var iconImageView: UIImageView?

    /// The row of the view
    public private(set) var row: Row?

    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: Row) {
        self.row = row
        titleLabel?.text = row.title
        iconImageView?.image = row.icon
        iconImageView?.isHidden = row.icon == nil
        isHidden = row.isHidden
    }
}

import UIKit
