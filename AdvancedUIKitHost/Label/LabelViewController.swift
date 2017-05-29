class LabelViewController: UIViewController {
    
    @IBOutlet weak var dynamicLabel: UILabel!
    @IBOutlet weak var endTagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dynamicLabel.frame = CGRect(x: dynamicLabel.frame.origin.x, y: dynamicLabel.frame.origin.y, width: dynamicLabel.frame.width, height: dynamicLabel.actualHeight)
        endTagLabel.frame.origin = dynamicLabel.endPosition
    }
    
}

import UIKit
import AdvancedUIKit
