/// TableRowReusable defines a reusable table cell row
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
public protocol TableRowReusable: AnyObject {
    var tableIdentifier: String { get }
}

/// A row type that conforms to TableRowReusable
public typealias TableReusableRowType = TableRowReusable & RowType
