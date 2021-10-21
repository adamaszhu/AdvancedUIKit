/// CollectionCell defines a cell that contains a basic view.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class CollectionCell<V: View<R>, R: RowType>: UICollectionViewCell {

    /// The main part of the cell
    public private(set) var view: V?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Initialize the cell
    private func initialize() {
        let view = V()
        addSubview(view)
        view.pinEdgesToSuperview()
        self.view = view
    }

    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: R) {
        view?.configure(with: row)
    }
}

import UIKit
