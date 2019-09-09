/// InfiniteCell is used to display one of the infinite items.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
open class InfiniteCell: UITableViewCell {
    
    /// The additional view that should be shown after being expanded. Nil stands for not expandable.
    @IBOutlet public weak var additionalView: UIView?
    
    /// The button used to switch expand status.
    @IBOutlet public weak var switchButton: UIButton? {
        didSet {
            switchButton?.addTarget(self, action: #selector(getter: switchExpandStatusAction), for: .touchUpInside)
        }
    }
    
    /// Whether the cell can be expanded or not.
    var isExpandable: Bool {
        return additionalView != nil
    }
    
    /// The action of clicking the switch button.
    @objc var switchExpandStatusAction: () -> Void = {}
    
    /// Render the cell with an item.
    /// - parameter item: The item to be rendered.
    open func render(withItem item: Any) {}
    
    /// Expand the cell.
    open func expand() {}
    
    /// Collapse the cell.
    open func collapse() {}
}

import UIKit
