/// RowPresentable defines how the view should look like for a row.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public protocol RowPresentable: AnyObject {

    /// The view that presents the row
    var view: UIView { get }
}

import UIKit
