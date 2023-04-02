/// CollectionRowReusable defines a reusable  collection cell row
///
/// - version: 1.8.0
/// - date: 19/08/22
/// - author: Adamas
public protocol CollectionRowReusable: AnyObject {
    
    /// The cell reusable identifier
    var collectionIdentifier: String { get }
}

/// A row type that conforms to CollectionRowReusable
public typealias CollectionReusableRowType = CollectionRowReusable & RowType
