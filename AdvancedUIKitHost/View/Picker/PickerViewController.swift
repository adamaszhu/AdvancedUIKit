final class PickerViewController: UIViewController {
    
    private let pickerOptions = ["China", "Australia", "America"]
    private let pickerTitle = "Country"
    private let pickerTitleColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    
    @IBOutlet weak var showDataPickerButton: UIButton!
    @IBOutlet weak var dataPicker: DataPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataPickerDelegate = self
        let items = pickerOptions.map {
            DataPickerItem(value: $0)
        }
        dataPicker.title = pickerTitle
        dataPicker.titleBackgroundColor = pickerTitleColor
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
