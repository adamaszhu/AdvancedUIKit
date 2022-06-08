/// CollectionCell defines the basic of a collection cell
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
open class CollectionCell<V: View<R>, R: RowType>: UICollectionViewCell, RowConfigurable {
    
    /// Reusable id of the cell type
    public static var reusableIdentifier: String {
        String(describing: Self.self)
    }

    /// The main part of the cell
    public private(set) var view: V?

    /// Quick access to the row
    public var row: R? {
        view?.row
    }

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
        contentView.addSubview(view)
        view.pinEdgesToSuperview()
        self.view = view
    }

    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: RowType) {
        guard let row = row as? R else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: R.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        view?.configure(with: row)
    }

    /// Error
    static var rowErrorPattern: String { "Expect row type as %@ got %@" }
}

import UIKit
