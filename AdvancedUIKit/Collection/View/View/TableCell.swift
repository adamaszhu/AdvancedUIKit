/// TableCell defines a cell that contains a basic view.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class TableCell<V: View<R>, R: RowType>: UITableViewCell {

    /// The main part of the cell
    public private(set) var view: V?

    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: R) {
        view?.configure(with: row)
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Initialize the cell
    private func initialize() {
        let view = V()
        contentView.addSubview(view)
        view.pinEdgesToSuperview()
        self.view = view
    }
}

import UIKit
