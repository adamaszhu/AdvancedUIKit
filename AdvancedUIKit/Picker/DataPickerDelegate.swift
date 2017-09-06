/// DataPickerDelegate contains the action to be performed when an action happens in the DataPicker.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 23/04/2017
public protocol DataPickerDelegate {
    
    /// DataPicker has a selected value.
    ///
    /// - Parameter values: The value for each column.
    func dataPicker(dataPicker: DataPicker, didSelectValue values: Array<String>)
    
}
