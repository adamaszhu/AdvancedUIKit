#if !os(macOS)
/// DataPickerDelegate contains the action to be performed when an action happens in the DataPicker.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
public protocol DataPickerDelegate: AnyObject {
    
    /// DataPicker has a selected value.
    ///
    /// - Parameter values: The value for each column.
    func dataPicker(_ dataPicker: DataPicker,
                    didSelectValue values: [String])
}
#endif
