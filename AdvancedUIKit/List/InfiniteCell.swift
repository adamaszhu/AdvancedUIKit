/**
 * InfiniteCell is used to display one of the infinite items.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/06/2017
 */
open class InfiniteCell: UITableViewCell {
    
    /**
     * The additional view that should be shown after being expanded. Nil stands for not expandable.
     */
    @IBOutlet public var additionalView: UIView?
    
    /**
     * Render the cell with an item.
     * - parameter item: The item to be rendered.
     */
    open func render(_ item: Any) {
    }
    
}

import UIKit
