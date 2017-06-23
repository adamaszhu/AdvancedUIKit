/**
 * InfiniteListDelegate defines the action triggered in the list.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 24/06/2017
 */
public protocol InfiniteListDelegate {
    
    /**
     * An item is selected.
     * - parameter item: The item of the cell that is selected.
     */
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any)
    
}

import Foundation
