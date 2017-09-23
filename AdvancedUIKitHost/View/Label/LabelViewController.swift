final class LabelViewController: UIViewController {
    
    @IBOutlet weak var dynamicLabel: UILabel!
    @IBOutlet weak var endTagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endTagLabel.frame.size = .init(width: endTagLabel.frame.width, height: endTagLabel.actualHeight)
        endTagLabel.frame.origin = dynamicLabel.endPosition
    }
    
}

import UIKit
