final class MainViewController: UIViewController {
    
    @IBOutlet weak var featureTable: UITableView!
    
    let features = [.audio, .button, .device, .image, .keyboard, .label, .list, .localization, .location, .map, .message, .navigation, .notification, .picker, .textField, .view] as [Feature]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
    }
    
}

import UIKit
