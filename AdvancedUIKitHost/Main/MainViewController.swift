class MainViewController: UIViewController {
    
    @IBOutlet weak var featureTable: UITableView!
    
    var features: Array<Feature>
    
    required init?(coder aDecoder: NSCoder) {
        features = [.audio, .device, .label, .message, .notification, .picker]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
    }
    
}

import UIKit
