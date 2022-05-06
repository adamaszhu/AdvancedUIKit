/// TableViewFactory defines a factory for generating table components
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
open class TableViewFactory {

    /// Generate a cell
    /// - Parameters:
    ///   - row: The row used to configure the cell
    ///   - tableView: The table view
    ///   - indexPath: The index of the cell
    /// - Returns: The generated cell
    public static func cell(for row: ReusableRowType,
                     in tableView: UITableView,
                     at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        if let cell = cell as? RowConfigurable {
            cell.configure(with: row)
        }
        return cell
    }
}

import UIKit
