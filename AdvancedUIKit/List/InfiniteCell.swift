/// InfiniteCell is used to display one of the infinite items.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 22/06/2017
open class InfiniteCell: UITableViewCell {
    
    /// The additional view that should be shown after being expanded. Nil stands for not expandable.
    @IBOutlet public weak var additionalView: UIView?
    
    /// The button used to switch expand status.
    @IBOutlet public weak var switchButton: UIButton? {
        didSet {
            switchButton?.addTarget(self, action: #selector(switchExpandStatus), for: .touchUpInside)
        }
    }
    
    /// Whether the cell can be expanded or not.
    var isExpandable: Bool {
        return additionalView != nil
    }
    
    /// The action of clicking the switch button.
    var switchExpandStatusAction: (() -> Void)!
    
    /// Render the cell with an item.
    /// - parameter item: The item to be rendered.
    open func render(item: Any) {
    }
    
    /// Expand the cell.
    open func expand() {
    }
    
    /// Collapse the cell.
    open func collapse() {
    }
    
    /// Switch the expand status of current cell.
    func switchExpandStatus() {
        switchExpandStatusAction()
    }
    
}

import UIKit
