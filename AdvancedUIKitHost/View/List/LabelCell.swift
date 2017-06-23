class LabelCell: InfiniteCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func render(_ item: Any) {
        label.text = "\(item)"
    }
    
}

import AdvancedUIKit
import UIKit
