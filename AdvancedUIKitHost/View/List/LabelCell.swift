final class LabelCell: InfiniteCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var switchIcon: UIImageView!
    
    override func render(withItem item: Any) {
        label.text = "\(item)"
    }
    
    override func expand() {
        super.expand()
        switchIcon.image = UIImage(named: LabelCell.expandedCellIconName)
    }
    
    override func collapse() {
        super.collapse()
        switchIcon.image = UIImage(named: LabelCell.collapsedCellIconName)
    }
}

private extension LabelCell {
    static let expandedCellIconName = "CollapseCell"
    static let collapsedCellIconName = "ExpandCell"
}

import AdvancedUIKit
import UIKit
