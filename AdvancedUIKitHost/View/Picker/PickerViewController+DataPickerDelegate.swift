extension PickerViewController: DataPickerDelegate {
    
    func dataPicker(dataPicker: DataPicker, didSelectValue values: Array<String>) {
        let value = values.first!
        showDataPickerButton.setTitle(value, for: .normal)
    }
    
}

import AdvancedUIKit
import UIKit
