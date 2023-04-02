/// CollectionViewFactory defines a factory for generating collection components
///
/// - version: 1.8.0
/// - date: 07/06/22
/// - author: Adamasp
open class CollectionViewFactory {
    
    /// Get a reusable cell instance
    /// - Parameters:
    ///   - row: The row of the cell
    ///   - collectionView: The collection view that holds the cell
    ///   - indexPath: The index path of the cell
    /// - Returns: A cell instance
    public static func cell(for row: CollectionReusableRowType,
                            in collectionView: UICollectionView,
                            at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.collectionIdentifier,
                                                      for: indexPath)
        if let cell = cell as? RowConfigurable {
            cell.configure(with: row)
        }
        return cell
    }
}

import UIKit
