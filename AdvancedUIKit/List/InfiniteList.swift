/// InfiniteList is a list that can load infinite items.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 21/06/2017
public class InfiniteList: UITableView {
    
    /// System errors.
    static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    static let cellError = "The cell is not an InfiniteCell."
    static let cellRegistrationError = "The cell has not been registered yet."
    
    /// System warnings.
    static let emptyStateShowWarning = "The empty state has already been shown."
    static let emptyStateHideWarning = "The empty state has already been hidden."
    
    /// The default minimal page size.
    static let defaultPageSize = 10
    
    /// Delegate for action related to the InfiniteList.
    public var infiniteListDelegate: InfiniteListDelegate? {
        didSet {
            if status.isReloading {
                infiniteListDelegate?.infiniteListDidRequireReload(self)
            }
        }
    }
    
    /// The item amount of each page.
    public var pageSize: Int
    
    /// Whether the list can be edited or not.
    public var isEditable: Bool
    
    /// The items displayed on the screen.
    var items: [InfiniteItem]
    
    /// All registered types.
    var cellTypes: [InfiniteCellType]
    
    /// The empty view displayed if no item is retieved.
    var emptyState: UIView?
    
    /// The reloading bar at the top of the list. If it is nil, then reload function will be disabled.
    var reloadingBar: UIView?
    
    /// The loading more bar at the bottom of the list. If it is nil, then load more function will be disabled.
    var loadingMoreBar: UIView?
    
    /// The page amount.
    var pageAmount: Int
    
    /// The index of cell that is currently expanded.
    var expandedCellIndexPath: IndexPath? {
        didSet {
            beginUpdates()
            endUpdates()
        }
    }
    
    /// The status of the list.
    var status: InfiniteListStatus {
        didSet {
            loadingMoreBar?.isHidden = status.isLoadingMoreBarHidden
            var newContentOffset = contentOffset
            switch status {
            case .infinite:
                newContentOffset = .init(x: 0, y: 0)
            case .empty:
                newContentOffset = .init(x: 0, y: 0)
            case .reloading:
                pageAmount = 0
                newContentOffset.init(x: 0, y: -loadingMoreBarHeight)
            default:
                break
            }
            setContentOffset(newContentOffset, animated: true)
        }
    }
    
    
    
    //    /**
    //     * Reload the list.
    //     * - version: 0.0.9
    //     * - date: 23/10/2016
    //     * - parameter itemList: The list to be reload.
    //     */
    //    public func reloadList(itemList: Array<AnyObject>) {
    //        self.itemList.removeAll()
    //        for item in itemList {
    //            self.itemList.append(item)
    //        }
    //        switch status {
    //        case .Initial, .Reloading:
    //            if shouldLoadMore {
    //                hasMoreItem = itemList.count < DynamicList.MinPageSize ? false : true
    //            } else {
    //                hasMoreItem = false
    //            }
    //            pageCount = 1
    //            pageSize = hasMoreItem ? itemList.count : DynamicList.MinPageSize
    //            reloadData()
    //            stopReloading()
    //        case .LoadingMore, .Idle:
    //            logError(DynamicList.StatusError)
    //        }
    //    }
    
    
    /**
     * Reload a list of items.
     * - parameter items: The items to be reloaded.
     */
    public func reload(_ items: Array<InfiniteItem>) {
        self.items = items
        reloadData()
        expandedCellIndex = nil
        if items.count == 0 {
            status = .empty
            showEmptyState()
        } else if items.count < pageSize {
            status = .finite
            hideEmptyState()
        } else {
            status = .infinite
            hideEmptyState()
        }
        loadMoreBar?.frame.origin = .init(x: 0, y: contentSize.height)
    }
    
    /**
     * Clear all items
     */
    public func clear() {
        reload([])
    }
    
    //
    //    /**
    //     * Append a list to the end of the item list.
    //     * - version: 0.0.9
    //     * - date: 23/10/2016
    //     * - parameter itemList: The list to be appended.
    //     */
    //    public func appendList(itemList: Array<AnyObject>) {
    //        switch status {
    //        case .LoadingMore:
    //            for item in itemList {
    //                self.itemList.append(item)
    //            }
    //            status = DynamicListStatus.Idle
    //            // COMMENT: Not enough new items found.
    //            if itemList.count < pageSize {
    //                hasMoreItem = false
    //            }
    //            pageCount += 1
    //            reloadData()
    //        case .Initial, .Reloading, .Idle:
    //            logError(DynamicList.StatusError)
    //        }
    //    }
    
    /**
     * Append a list of items.
     * - parameter items: The items to be append.
     */
    public func append(_ items: Array<InfiniteItem>) {
        self.items = self.items + items
        pageAmount = pageAmount + 1
        reloadData()
        if items.count < pageSize {
            status = .finite
        } else {
            status = .infinite
        }
        loadMoreBar?.frame.origin = .init(x: 0, y: contentSize.height)
    }
    
    /**
     * Define the nib file used to render an item cell.
     * - parameter nib: The nib file.
     * - parameter type: The item cell type.
     */
    public func register(_ nib: UINib, for type: InfiniteCell.Type) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registerStatusError, withDetail: type)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.nibError, withDetail: type)
            return
        }
        let cellType = InfiniteCellType(type: type, height: view.frame.height, additionalHeight: view.additionalView?.frame.height)
        cellTypes.append(cellType)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
    
    /**
     * Register the empty state view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerEmptyState(_ nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registerStatusError)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.emptyStateError)
            return
        }
        view.frame = bounds
        emptyState = view
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        if let reloadBar = reloadBar, reloadBar.superview == nil {
            addSubview(reloadBar)
            let height = reloadBar.frame.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [unowned self] _ in
                // COMMENT: Wait for the subview to be resized.
                reloadBar.frame.size = .init(width: reloadBar.frame.width, height: height)
                // COMMENT: Adjust the scroll offset.
                self.scrollViewDidScroll(self)
            })
        }
        if let loadMoreBar = loadMoreBar, loadMoreBar.superview == nil {
            addSubview(loadMoreBar)
        }
    }
    
    /**
     * Show the empty state.
     */
    func showEmptyState() {
        guard let emptyState = emptyState else {
            return
        }
        guard emptyState.superview == nil else {
            Logger.standard.logError(InfiniteList.emptyStateShowingWarning)
            return
        }
        emptyState.animate(withChange: {
            emptyState.alpha = 1
        }, withPreparation: { [unowned self] _ in
            emptyState.alpha = 0
            self.addSubview(emptyState)
        })
    }
    
    /**
     * Hide the empty state.
     */
    func hideEmptyState() {
        guard let emptyState = emptyState else {
            return
        }
        guard emptyState.superview != nil else {
            Logger.standard.logError(InfiniteList.emptyStateHidingWarning)
            return
        }
        emptyState.animate(withChange: {
            emptyState.alpha = 0
        }, withPreparation: {
            emptyState.alpha = 1
        }, withCompletion: {
            emptyState.removeFromSuperview()
        })
    }
    
    /**
     * Find the cell type for a specific cell.
     * - parameter type: The type of the cell.
     * - returns: Found cell type. Nil if it is not found.
     */
    func cellType(for type: InfiniteCell.Type) -> InfiniteCellType? {
        for cellType in cellTypes {
            if cellType.type == type {
                return cellType
            }
        }
        Logger.standard.logError(InfiniteList.registerError, withDetail: type)
        return nil
    }
    
    /**
     * UITableView
     */
    public required init?(coder aDecoder: NSCoder) {
        items = []
        cellTypes = []
        status = .initial
        pageAmount = 0
        isEditable = false
        pageSize = InfiniteList.defaultPageSize
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
    
}

import UIKit
