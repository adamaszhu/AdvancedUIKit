final class PickerViewController: UIViewController {
    
    @IBOutlet private weak var showDataPickerButton: UIButton!
    @IBOutlet private weak var dataPicker: DataPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataPickerDelegate = self
        let items = PickerViewController.pickerOptions.map { DataPickerItem(value: $0) }
        dataPicker.title = PickerViewController.pickerTitle
        dataPicker.titleBackgroundColor = PickerViewController.pickerTitleColor
        dataPicker.setSingleColumn(items)
        dataPicker.trigger = showDataPickerButton
        if let title = showDataPickerButton.titleLabel?.text {
            dataPicker.selectValue(title)
        }
    }
    
    @IBAction func showDataPicker(_ sender: Any) {
        dataPicker.show()
    }
}

extension PickerViewController: DataPickerDelegate {
    
    func dataPicker(_ dataPicker: DataPicker, didSelectValue values: [String]) {
        let value = values.first
        showDataPickerButton.setTitle(value, for: .normal)
    }
}

private extension PickerViewController {
    static let pickerOptions = ["China", "Australia", "America"]
    static let pickerTitle = "Country"
    static let pickerTitleColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
}

import AdvancedUIKit
import UIKit
