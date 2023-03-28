/// ValueRow presents a row that has a value
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
open class ValueRow: LabelRow, ValueRowType {
    
    public let value: String?

    public init(icon: UIImage? = nil,
                title: String? = nil,
                subtitle: String? = nil,
                value: String? = nil) {
        self.value = value
        super.init(icon: icon, title: title, subtitle: subtitle)
    }
}

public protocol ValueRowType: LabelRowType {
    
    /// The value that the row presents
    var value: String? { get }
}

import UIKit
