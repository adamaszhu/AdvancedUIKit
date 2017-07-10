/// InfiniteListStatus represents the status of an InfiniteList.
/// - version: 1.0.0
/// - date: 03/07/2016
/// - author: Adamas
enum InfiniteListStatus {
    
    /// The initial status
    case initial
    
    /// More items are available.
    case infinite
    
    /// All items have been loaded.
    case finite
    
    /// No item is available.
    case empty
    
    /// Waiting for more items to be loaded.
    case loadingMore
    
    /// Waiting for reloading all items.
    case reloading
    
}
