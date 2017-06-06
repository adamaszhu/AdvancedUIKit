/**
 * DataPickerColumn presents a column in the DataPicker.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 23/04/2017
 */
public struct DataPickerColumn {
    
    /**
     * Attributes.
     */
    let title: String
    let items: Array<DataPickerItem>
    
    /**
     * Initialize the column.
     * - parameter title: The title of the column. Empty is the default value.
     * - parameter items: The column items.
     */
    init(title: String = "", items: Array<DataPickerItem>) {
        self.title = title
        self.items = items
    }
    
}
