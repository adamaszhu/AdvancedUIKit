class MainViewController: UIViewController {
    
    @IBOutlet weak var featureTable: UITableView!
    
    var features: [Feature]
    
    required init?(coder aDecoder: NSCoder) {
        features = [.audio, .button, .device, .image, .keyboard, .label, .list, .localization, .location, .map, .message, .navigation, .notification, .picker, .textField, .view]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
    }
    
}

import UIKit
