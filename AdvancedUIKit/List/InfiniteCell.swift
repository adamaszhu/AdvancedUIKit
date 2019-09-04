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
            switchButton?.addTarget(self, action: #selector(switchExpandStatus), for: .touchUpInside)
        }
    }
    
    /// Whether the cell can be expanded or not.
    var isExpandable: Bool {
        return additionalView != nil
    }
    
    /// The action of clicking the switch button.
    var switchExpandStatusAction: () -> Void = {}
    
    /// Render the cell with an item.
    /// - parameter item: The item to be rendered.
    @objc open func render(withItem item: Any) { }
    
    /// Expand the cell.
    @objc open func expand() { }
    
    /// Collapse the cell.
    @objc open func collapse() { }
    
    /// Switch the expand status of current cell.
    @objc func switchExpandStatus() {
        switchExpandStatusAction()
    }
    
}

import UIKit
