class PickerViewController: UIViewController {
    
    private let countries = ["China", "Australia", "America"]
    private let country = "Country"
    
    @IBOutlet weak var showDataPickerButton: UIButton!
    @IBOutlet weak var dataPicker: DataPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataPickerDelegate = self
        let items = countries.map { (country) -> DataPickerItem in
            DataPickerItem(value: country)
        }
        dataPicker.title = country
        dataPicker.titleBackgroundColor = UIColor.brown
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
