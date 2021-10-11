/// CollectionCell defines a cell that contains a basic view.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class CollectionCell<V: View<R>, R: RowType>: UICollectionViewCell {

    /// The main part of the cell
    public private(set) var view: V?

    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: R) {
        view?.configure(with: row)
    }
}

import UIKit
