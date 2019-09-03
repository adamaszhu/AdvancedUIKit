/// DataPickerColumn presents a column in the DataPicker.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
public struct DataPickerColumn {
    
    /// Attributes.
    let title: String
    let items: [DataPickerItem]
    
    /// Initialize the column.
    ///
    /// - Parameters:
    ///   - title: The title of the column. Empty is the default value.
    ///   - items: The column items.
    public init(items: [DataPickerItem], title: String = .empty) {
        self.title = title
        self.items = items
    }
}
