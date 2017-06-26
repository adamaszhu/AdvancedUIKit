class LabelCell: InfiniteCell {
    
    private let expandedCellIconName = "CollapseCell"
    private let collapsedCellIconName = "ExpandCell"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchIcon: UIImageView!
    
    override var isExpanded: Bool! {
        didSet {
            switchIcon.image = UIImage(named: isExpanded ? expandedCellIconName : collapsedCellIconName)
        }
    }
    
    override func render(_ item: Any) {
        label.text = "\(item)"
    }
    
}

import AdvancedUIKit
import UIKit
