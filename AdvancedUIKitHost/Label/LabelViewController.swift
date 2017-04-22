class LabelViewController: UIViewController {
    
    @IBOutlet weak var dynamicLabel: UILabel!
    @IBOutlet weak var endTagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        endTagLabel.frame.origin = dynamicLabel.endPosition
    }
    
}

import UIKit
import AdvancedUIKit
