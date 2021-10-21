/// Row presents a single item in the collection.
///
/// - version: 1.8.0
/// - date: 05/10/21
/// - author: Adamas
open class Row: RowType {

    public let title: String?
    public let icon: UIImage?
    public var reloadAction: (() -> Void)?

    public var isHidden: Bool = false {
        didSet {
            reloadAction?()
        }
    }

    /// Create a row
    /// - Parameters:
    ///   - icon: The icon of the row. Default to nil.
    ///   - title: The title of the row. Default to nil.
    public init(icon: UIImage? = nil,
                title: String? = nil) {
        self.title = title
        self.icon = icon
    }
}

/// The interface of a row
public protocol RowType: AnyObject {

    /// The title of the row
    var title: String? { get }

    /// The icon of the row
    var icon: UIImage? { get }

    /// The visibility of the row
    var isHidden: Bool { get set }

    /// Callback when the view should be updated
    var reloadAction: (() -> Void)? { get set }
}

import UIKit
