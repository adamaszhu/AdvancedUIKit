/// ItemsRow presents a list of capsule items who are tappable.
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class ItemsRow<ItemRow: TapRowType>: Row, ItemsRowType {

    public var rows: [ItemRow] = [] {
        didSet {
            isHidden = rows.isEmpty
        }
    }

    /// Create a row
    public init() {
        super.init(icon: nil, title: nil)
    }
}

/// The interface of a tags row
public protocol ItemsRowType: RowType {

    /// The type of rows to be presented
    associatedtype ItemRow

    /// The list of rows to be presented on the screen
    var rows: [ItemRow] { get set }
}
