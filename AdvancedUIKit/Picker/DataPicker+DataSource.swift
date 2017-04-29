/**
 * DataPicker+DataSource provides data to a picker view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 23/04/2017
 */
extension DataPicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return columns.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return columns[component].items.count
    }
    
}

import UIKit
