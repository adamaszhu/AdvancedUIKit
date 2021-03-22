final class PickerViewController: UIViewController {
    
    @IBOutlet private weak var showAccuratePickerButton: UIButton!
    @IBOutlet private weak var showDataPickerButton: UIButton!
    @IBOutlet private weak var dataPicker: DataPicker!
    
    private let pickerOptions: [String] = ["China", "Australia", "America"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.delegate = self
        dataPicker.title = Self.pickerTitle
        dataPicker.titleBackgroundColor = Self.pickerTitleColor
    }
    
    @IBAction func showDataPicker(_ sender: Any) {
        let column = pickerOptions.map { DataPickerItem(value: $0) }
        dataPicker.set(column)
        dataPicker.trigger = showDataPickerButton
        dataPicker.show()
        if let title = showDataPickerButton.titleLabel?.text {
            dataPicker.selectValue(title)
        }
    }
    
    @IBAction func showAccuratePicker(_ sender: Any) {
        let column = pickerOptions.map { DataPickerItem(value: $0) }
        let columns = [DataPickerColumn(items: column), DataPickerColumn(items: column)]
        dataPicker.set(columns)
        dataPicker.trigger = showAccuratePickerButton
        dataPicker.show()
        if let title = showDataPickerButton.titleLabel?.text {
            dataPicker.selectValue(title)
            dataPicker.selectValue(title, atColumn: 1)
        }
    }
}

extension PickerViewController: DataPickerDelegate {
    
    func dataPicker(_ dataPicker: DataPicker, didSelectValue values: [String]) {
        let value1 = values.first
        let value2 = values.last
        if value1 == value2 {
            showDataPickerButton.setTitle(value1, for: .normal)
        }
    }
}

private extension PickerViewController {
    static let pickerTitle = "Country"
    static let pickerTitleColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
}

import AdvancedUIKit
import UIKit
