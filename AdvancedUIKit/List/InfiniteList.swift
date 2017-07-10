/// InfiniteList is a list that can load infinite items.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 21/06/2017
public class InfiniteList: UITableView {
    
    /// System errors.
    static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    static let cellError = "The cell is not an InfiniteCell."
    static let cellRegistrationError = "The cell has not been registered yet."
    static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    static let emptyStateRegistrationError = "The empty state has not been registered yet."
    
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
            case .infinite, .empty:
                newContentOffset = .init(x: 0, y: 0)
            case .reloading:
                newContentOffset = .init(x: 0, y: reloadingOffsetY)
            case .loadingMore:
                newContentOffset = .init(x: 0, y: loadingMoreOffsetY)
            default:
                break
            }
            setContentOffset(newContentOffset, animated: true)
            loadingMoreBar?.frame.origin = .init(x: 0, y: contentSize.height)
        }
    }
    
    /// Reload a list of items.
    /// - parameter items: The items to be reloaded.
    public func reload(_ items: [InfiniteItem]) {
        guard status.isReloading else {
            return
        }
        self.items = items
        pageAmount = 0
        reloadData()
        expandedCellIndexPath = nil
        switch items.count {
        case 0:
            status = .empty
            showEmptyState()
        case 1 ..< pageSize:
            status = .finite
            hideEmptyState()
        default:
            status = .infinite
            hideEmptyState()
        }
    }
    
    /// Clear all items
    public func clear() {
        reload([])
    }
    
    /// Append a list of items.
    /// - parameter items: The items to be append.
    public func append(_ items: [InfiniteItem]) {
        guard status.isLoadingMore else {
            return
        }
        self.items = self.items + items
        pageAmount = pageAmount + 1
        reloadData()
        switch items.count {
        case 0 ..< pageSize:
            status = .finite
        default:
            status = .infinite
        }
    }
    
    /// Define the nib file used to render an item cell.
    /// - parameter nib: The nib file.
    /// - parameter type: The item cell type.
    public func register(_ type: InfiniteCell.Type, with nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.cellNibError, withDetail: type)
            return
        }
        let cellType = InfiniteCellType(type: type, basicHeight: view.frame.height, additionalHeight: view.additionalView?.frame.height)
        cellTypes.append(cellType)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
    
    /// Register the empty state view for the InfiniteList.
    /// - parameter nib: The nib file containing the view.
    public func registerEmptyState(_ nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.emptyStateNibError)
            return
        }
        view.frame = bounds
        emptyState = view
    }
    
    /// Show the empty state.
    func showEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard emptyState.superview == nil else {
            Logger.standard.logWarning(InfiniteList.emptyStateShowWarning)
            return
        }
        emptyState.animate(withChange: {
            emptyState.alpha = 1
        }, withPreparation: {
            emptyState.alpha = 0
            self.addSubview(emptyState)
        })
    }
    
    /// Hide the empty state.
    func hideEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard emptyState.superview != nil else {
            Logger.standard.logWarning(InfiniteList.emptyStateHideWarning)
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
    
    /// Find the cell type for a specific cell.
    /// - parameter type: The type of the cell.
    /// - returns: Found cell type. Nil if it is not found.
    func cellType(for type: InfiniteCell.Type) -> InfiniteCellType? {
        for cellType in cellTypes {
            if cellType.type == type {
                return cellType
            }
        }
        Logger.standard.logError(InfiniteList.cellRegistrationError, withDetail: type)
        return nil
    }
    
    /// UIView
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        if let reloadingBar = reloadingBar, reloadingBar.superview == nil {
            addSubview(reloadingBar)
            let height = reloadingBar.frame.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                // COMMENT: Wait for the subview to be resized.
                reloadingBar.frame.size = .init(width: reloadingBar.frame.width, height: height)
                // COMMENT: Adjust the scroll offset.
                self.scrollViewDidScroll(self)
            })
        }
        if let loadingMoreBar = loadingMoreBar, loadingMoreBar.superview == nil {
            addSubview(loadingMoreBar)
        }
    }
    
    /// UIView
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
