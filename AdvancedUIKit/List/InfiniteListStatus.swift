/// InfiniteListStatus represents the status of an InfiniteList.
/// - version: 1.0.0
/// - date: 03/07/2016
/// - author: Adamas
enum InfiniteListStatus {
    
    /// The list has just been initialized.
    case initial
    
    /// More items are available.
    case infinite
    
    /// All items have been loaded.
    case finite
    
    /// No item is available.
    case empty
    
    /// More items are expected to be loaded.
    case loadingMore
    
    /// All items are expected to be reloaded.
    case reloading
    
}
