class LabelCell: InfiniteCell {
    
    private let expandedCellIconName = "CollapseCell"
    private let collapsedCellIconName = "ExpandCell"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchIcon: UIImageView!
    
    override func render(_ item: Any) {
        label.text = "\(item)"
    }
    
    override func expand() {
        switchIcon.image = UIImage(named: expandedCellIconName)
    }
    
    override func collapse() {
        switchIcon.image = UIImage(named: collapsedCellIconName)
    }
    
}

import AdvancedUIKit
import UIKit
