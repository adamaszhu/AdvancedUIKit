/// InfiniteList+Constant defines all constants used by InfiniteList.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension InfiniteList {
    
    /// System errors.
    static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    static let cellError = "The cell is not an InfiniteCell."
    static let cellRegistrationError = "The cell has not been registered yet."
    static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    static let emptyStateRegistrationError = "The empty state has not been registered yet."
    static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    static let loadingMoreBarNibError = "The nib file doesn't contain a UIView for the loading more bar."
    static let reloadingBarRegistrationError = "The reloading bar hasn't been registered yet."
    static let displayStatusError = "The items cannot be displayed under current status."
    
    /// System warnings.
    static let emptyStateShowWarning = "The empty state has already been shown."
    static let emptyStateHideWarning = "The empty state has already been hidden."
    static let cellExpansionWarning = "The cell cannot be expanded."
    static let cellCollapsionWarning = "The cell cannot be collapsed."
    
    /// The default minimal page size.
    static let defaultPageSize = 10
    
}
