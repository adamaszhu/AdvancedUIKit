final class LabelViewController: UIViewController {
    
    @IBOutlet private weak var dynamicLabel: UILabel!
    @IBOutlet private weak var endTagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endTagLabel.frame.size = CGSize(width: endTagLabel.frame.width, height: endTagLabel.actualHeight)
        endTagLabel.frame.origin = dynamicLabel.endPosition
    }
}

import UIKit
