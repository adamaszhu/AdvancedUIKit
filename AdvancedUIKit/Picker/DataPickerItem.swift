/// DataPickerItem presents an item in the DataPicker.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
public struct DataPickerItem {
    
    /// Attributes.
    let name: String
    let value: String
    
    /// Initialize a item.
    ///
    /// - Parameters:
    ///   - name: The name of the item. If it is nil, the value will be set as name instead.
    ///   - value: The value of the item.
    public init(name: String? = nil, value: String) {
        self.value = value
        self.name = name ?? value
    }
}
