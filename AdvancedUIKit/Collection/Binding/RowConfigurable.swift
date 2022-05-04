/// RowConfigurable defines the behavior of a view which can be binded to its row
///
/// - version: 1.8.0
/// - date: 02/05/22
/// - author: Adamas
public protocol RowConfigurable {
    func configure(with row: RowType)
}
