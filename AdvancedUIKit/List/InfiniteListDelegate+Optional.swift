/**
 * InfiniteListDelegate+Optional defines the default action triggered in the list.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/07/2017
 */
public extension InfiniteListDelegate {
    
    /**
     * An item is selected.
     * - parameter item: The item of the cell that is selected.
     */
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) { }
    
    /**
     * When load more action is activated.
     * - parameter pageIndex: The page index.
     */
    func infiniteList(_ infiniteList: InfiniteList, didRequireLoadPage page: Int) { }
    
    /**
     * When reload action is activated.
     */
    func infiniteListDidRequireReload(_ infiniteList: InfiniteList) { }
    
    /**
     * InfiniteListDelegate
     */
    func infiniteListDidScroll(_ infiniteList: InfiniteList) { }
    
    /**
     * When the item is deleted.
     */
    func infiniteList(_ infiniteList: InfiniteList, didDeleteItem item: Any) { }
    
}

import Foundation
