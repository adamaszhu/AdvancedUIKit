/// DataPickerItem presents an item in the DataPicker.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 23/04/2017
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
