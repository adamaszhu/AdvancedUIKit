import UIKit

/**
 * DynamicListDelegate performs the actions activated within the dynamic list.
 * - version: 0.0.3
 * - date: 23/10/2016
 * - author: Adamas
 */
@objc public protocol DynamicListDelegate {
    
    /**
     * Decide how to render the cell.
     * - version: 0.0.3
     * - date: 23/10/2016
     * - parameter cell: The cell to be rendered.
     * - parameter item: The item used to render the cell. If the item is nil, this is an accessory cell.
     */
    func dynamicList(dynamicList: DynamicList, didRequireRenderCell cell: UITableViewCell, withItem item: AnyObject)
    
    /**
     * When load more action is activated.
     * - version: 0.0.3
     * - date: 23/10/2016
     * - parameter pageIndex: The page index.
     */
    optional func dynamicList(dynamicList: DynamicList, didRequireLoadMore pageIndex: Int)
    
    /**
     * When reload action is activated.
     * - version: 0.0.3
     * - date: 23/10/2016
     */
    optional func dynamicListDidRequireReload(dynamicList: DynamicList)
    
    /**
     * When a row is selected.
     * - version: 0.0.3
     * - date: 23/10/2016
     * - parameter item: The item selected.
     */
    optional func dynamicList(dynamicList: DynamicList, didSelectItem item: AnyObject)
    
    /**
     * When the list is scrolled.
     * - version: 0.0.3
     * - date: 23/10/2016
     */
    optional func dynamicListDidScrollList(dynamicList: DynamicList)
    
    /**
     * When the item is deleted.
     * - version: 0.0.3
     * - date: 23/10/2016
     * - parameter item: The item to be deleted.
     */
    optional func dynamicList(dynamicList: DynamicList, didDeleteItem item: AnyObject)
    
}
