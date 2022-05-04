/// ItemsView defines the content of a list of view.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class ItemsView<ItemCell: CollectionCell<ItemView, ItemRow>,
                     Row: ItemsRow<ItemRow>,
                     ItemView: TapView<ItemRow>,
                     ItemRow: TapRowType>: View<Row>, UICollectionViewDelegate, UICollectionViewDataSource {

    /// The collection view represeting the carousel.
    @IBOutlet public private (set) var collectionView: UICollectionView? {
        didSet {
            setupCollectionView()
        }
    }

    /// The reusable id of the cell.
    private let cellID = String(describing: ItemView.self)
    
    /// Initialize the view
    private func setupCollectionView() {
        collectionView?.register(ItemCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    open override func configure(with row: Row) {
        super.configure(with: row)
        collectionView?.reloadData()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        row?.rows.count ?? 0
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ItemCell,
              let itemRow = row?.rows.element(atIndex: indexPath.item) else {
            Logger.standard.logError(Self.itemViewError)
            return UICollectionViewCell()
        }
        itemCell.configure(with: itemRow)
        return itemCell
    }

    public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemRow = row?.rows.element(atIndex: indexPath.item) else {
            Logger.standard.logError(Self.itemRowError)
            return
        }
        itemRow.didTapAction?()
    }
}

/// Constant
private extension ItemsView {

    /// System error
    static var itemRowError: String { "The item cannot be found in the row." }
    static var itemViewError: String { "The cell is not supported by the collection view" }
}

import AdvancedFoundation
import UIKit
