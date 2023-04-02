/// LabelRow presents a single item that has a sub title in the collection.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class LabelRow: Row, LabelRowType {

    public let subtitle: String?

    /// Create a row
    /// - Parameters:
    ///   - icon: The icon of the row. Default to nil.
    ///   - title: The title of the row. Default to nil.
    ///   - subtitle: The subtitle of the row. Default to nil.
    public init(icon: UIImage? = nil,
                title: String? = nil,
                subtitle: String? = nil) {
        self.subtitle = subtitle
        super.init(icon: icon, title: title)
    }
}

/// The interface of a label row
public protocol LabelRowType: RowType {

    /// The subtitle of the row
    var subtitle: String? { get }
}

import UIKit
