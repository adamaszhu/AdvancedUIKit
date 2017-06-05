class LabelViewController: UIViewController {
    
    @IBOutlet weak var dynamicLabel: UILabel!
    @IBOutlet weak var endTagLabel: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dynamicLabel.frame.size = CGSize(width: dynamicLabel.frame.width, height: dynamicLabel.actualHeight)
        endTagLabel.frame.origin = dynamicLabel.endPosition
    }
    
}

import UIKit
