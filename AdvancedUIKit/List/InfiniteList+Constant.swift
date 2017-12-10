/// InfiniteList+Constant defines all constants used by InfiniteList.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension InfiniteList {
    
    /// System errors.
    @objc static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    @objc static let cellError = "The cell is not an InfiniteCell."
    @objc static let cellRegistrationError = "The cell has not been registered yet."
    @objc static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    @objc static let emptyStateRegistrationError = "The empty state has not been registered yet."
    @objc static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    @objc static let loadingMoreBarNibError = "The nib file doesn't contain a UIView for the loading more bar."
    @objc static let reloadingBarRegistrationError = "The reloading bar hasn't been registered yet."
    @objc static let displayStatusError = "The items cannot be displayed under current status."
    
    /// System warnings.
    @objc static let emptyStateShowWarning = "The empty state has already been shown."
    @objc static let emptyStateHideWarning = "The empty state has already been hidden."
    @objc static let cellExpansionWarning = "The cell cannot be expanded."
    @objc static let cellCollapsionWarning = "The cell cannot be collapsed."
    
    /// The default minimal page size.
    @objc static let defaultPageSize = 10
    
}

import Foundation
