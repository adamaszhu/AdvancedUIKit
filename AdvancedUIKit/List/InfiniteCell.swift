/// InfiniteCell is used to display one of the infinite items.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
open class InfiniteCell: UITableViewCell {
    
    /// The button used to switch expand status.
    @IBOutlet public weak var switchButton: UIButton? {
        didSet {
            switchButton?.addTarget(self, action: #selector(switchExpandStatus), for: .touchUpInside)
        }
    }
    
    /// The additional view that should be shown after being expanded. Nil stands for not expandable.
    @IBOutlet public weak var additionalView: UIView? {
        didSet {
            additionalView?.clipsToBounds = true
            additionalViewHeightConstraint = additionalView?.heightAnchor.constraint(equalToConstant: 0)
            additionalViewHeightConstraint?.isActive = false
        }
    }
    
    /// Whether the cell can be expanded or not.
    var isExpandable: Bool {
        return additionalView != nil
    }
    
    /// The height of the additional view
    
    /// The action of clicking the switch button.
    var switchExpandStatusAction: () -> Void = {}
    
    /// The height constraints of the additional view before collapsing.
    private var additionalViewHeightConstraint: NSLayoutConstraint?
    
    /// The actual expand trigger
    @IBAction func switchExpandStatus() {
        switchExpandStatusAction()
    }
    
    /// Render the cell with an item.
    /// - parameter item: The item to be rendered.
    open func render(withItem item: Any) {}
    
    /// Expand the cell.
    open func expand() {
        animateChange({ [weak self] in
            self?.additionalViewHeightConstraint?.isActive = false
            self?.layoutIfNeeded()
        })
    }
    
    /// Collapse the cell.
    open func collapse() {
        animateChange({ [weak self] in
            self?.additionalViewHeightConstraint?.isActive = true
            self?.layoutIfNeeded()
        })
    }
}

import UIKit
