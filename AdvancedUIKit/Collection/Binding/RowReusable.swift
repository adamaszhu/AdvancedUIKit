/// RowReusable defines a reusable table cell row or collection cell row
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
public protocol RowReusable: AnyObject {
    var identifier: String { get }
}

/// A row type that conforms to RowReusable
public typealias ReusableRowType = RowReusable & RowType
