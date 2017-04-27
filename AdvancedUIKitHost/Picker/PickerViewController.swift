class PickerViewController: UIViewController, DataPickerDelegate {
    
    @IBOutlet weak var showDataPickerButton: UIButton!
    @IBOutlet weak var dataPicker: DataPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataPickerDelegate = self
        let items = [DataPickerItem(value: "China"), DataPickerItem(value: "Australia"), DataPickerItem(value: "America")]
        dataPicker.setSingleColumn(items)
        dataPicker.selectValue("Australia")
    }
    
    @IBAction func showDataPicker(_ sender: Any) {
        dataPicker.show()
    }
    
    func dataPicker(dataPicker: DataPicker, didSelectValue values: Array<String>) {
        let value = values.first!
        showDataPickerButton.setTitle(value, for: .normal)
    }
    
}

import AdvancedUIKit
import UIKit
