class PickerViewController: UIViewController {
    
    @IBOutlet weak var showDataPickerButton: UIButton!
    @IBOutlet weak var dataPicker: DataPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataPickerDelegate = self
        let items = [DataPickerItem(value: "China"), DataPickerItem(value: "Australia"), DataPickerItem(value: "America")]
        dataPicker.setSingleColumn(items)
        if let title = showDataPickerButton.titleLabel?.text {
            dataPicker.selectValue(title)
        }
    }
    
    @IBAction func showDataPicker(_ sender: Any) {
        dataPicker.show()
    }
    
}

import AdvancedUIKit
import UIKit
