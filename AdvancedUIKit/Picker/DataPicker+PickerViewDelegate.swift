/**
 * DataPicker+PickerViewDelegate presents the action to be done on a picker view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 23/04/2017
 */
extension DataPicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if view?.isKind(of: UILabel.self) == true {
            label = view as! UILabel
        } else {
            label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor.black
        }
        label.text = columns[component].items[row].name
        return label
    }
    
}

import UIKit
