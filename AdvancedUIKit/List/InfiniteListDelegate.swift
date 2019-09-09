/// InfiniteListDelegate defines the action triggered in the list.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 01/09/2019
public protocol InfiniteListDelegate: class {
    
    /// An item is selected.
    ///
    /// - Parameter item: The item of the cell that is selected.
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any)
    
    /// When load more action is activated.
    ///
    /// - Parameter pageIndex: The page index.
    func infiniteList(_ infiniteList: InfiniteList, didRequireLoadPage page: Int)
    
    /// When reload action is activated.
    func infiniteListDidRequireReload(_ infiniteList: InfiniteList)
    
    /// When the list is scrolled.
    func infiniteListDidScroll(_ infiniteList: InfiniteList)
    
    /// When the item is deleted.
    ///
    /// - Parameter item: The item to be deleted.
    func infiniteList(_ infiniteList: InfiniteList, didDeleteItem item: Any)
}
