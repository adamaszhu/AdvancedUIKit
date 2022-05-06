/// Provides additional access to a table cell
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
public extension UITableViewCell {

    /// Get the reorder control.
    var reloadorderControl: UIView? {
        guard isEditing else {
            return nil
        }
        return subviews.first { String(describing: $0) == Self.reorderControlName }
    }
}

private extension UITableViewCell {
    static let reorderControlName = "UITableViewCellReorderControl"
}

import UIKit
