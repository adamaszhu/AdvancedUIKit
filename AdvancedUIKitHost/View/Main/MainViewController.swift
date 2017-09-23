final class MainViewController: UIViewController {
    
    let features = [.audio, .button, .device, .image, .keyboard, .label, .list, .localization, .location, .map, .message, .navigation, .notification, .picker, .textField, .view] as [Feature]
    
    @IBOutlet weak var featureTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
    }
    
}

import UIKit
