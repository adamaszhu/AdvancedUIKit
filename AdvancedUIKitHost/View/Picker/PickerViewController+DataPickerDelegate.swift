extension PickerViewController: DataPickerDelegate {
    
    func dataPicker(dataPicker: DataPicker, didSelectValue values: [String]) {
        let value = values.first
        DispatchQueue.main.asyncAfter(deadline: .now() + UIView.defaultAnimationDuration) { [unowned self] _ in
            self.showDataPickerButton.setTitle(value, for: .normal)
        }
    }
    
}

import AdvancedUIKit
import UIKit
