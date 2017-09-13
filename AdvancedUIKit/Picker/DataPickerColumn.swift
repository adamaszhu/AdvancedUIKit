/// DataPickerColumn presents a column in the DataPicker.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 23/04/2017
public struct DataPickerColumn {
    
    /// Attributes.
    let title: String
    let items: [DataPickerItem]
    
    /// Initialize the column.
    ///
    /// - Parameters:
    ///   - title: The title of the column. Empty is the default value.
    ///   - items: The column items.
    init(items: [DataPickerItem], title: String = "") {
        self.title = title
        self.items = items
    }
    
}
