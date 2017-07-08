/**
 * InfiniteList is a list that can load infinite items.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 21/06/2017
 */
public class InfiniteList: UITableView {
    
    /**
     * System error.
     */
    static let nibError = "The nib file doesn't contain the customized InfiniteCell."
    static let emptyStateError = "The nib file doesn't contain a UIView for the empty state."
    static let reloadBarError = "The nib file doesn't contain a UIView for the reload bar."
    static let loadMoreBarError = "The nib file doesn't contain a UIView for the load more bar."
    static let cellError = "The cell is not an InfiniteCell."
    static let registerError = "The cell has not been registered yet."
    static let registerStatusError = "Please register all components before loading the actual data."
    
    /**
     * System warning.
     */
    static let expandWarning = "The cell cannot be expanded."
    static let collapseWarning = "The cell cannot be collapsed."
    static let emptyStateShowingWarning = "The empty state has already been shown."
    static let emptyStateHidingWarning = "The empty state has already been hidden."
    static let selectStatusWarning = "The list can not be selected at the moment."
    
    /**
     * The default minimal page size.
     */
    static let defaultPageSize = 10
    
    /**
     * Delegate
     */
    public var infiniteListDelegate: InfiniteListDelegate?
    
    /**
     * The items displayed on the screen.
     */
    var items: Array<InfiniteItem>
    
    /**
     * All registered types.
     */
    var cellTypes: Array<InfiniteCellType>
    
    /**
     * The empty view displayed if no item is retieved.
     */
    var emptyState: UIView?
    
    /**
     * The reload bar at the top of the list. If it is nil, then reload function will be disabled.
     */
    var reloadBar: UIView?
    
    /**
     * The load more bar at the bottom of the list. If it is nil, then load more function will be disabled.
     */
    var loadMoreBar: UIView?
    
    /**
     * The page amount.
     */
    var pageAmount: Int
    
    /**
     * The index of cell that is currently expanded.
     */
    var expandedCellIndex: IndexPath? {
        didSet {
            beginUpdates()
            endUpdates()
        }
    }
    
    /**
     * The status of the list.
     */
    var status: InfiniteListStatus {
        didSet {
            switch status {
            case .infinite:
                setContentOffset(.init(x: 0, y: 0), animated: true)
                loadMoreBar?.isHidden = false
            case .loadingMore, .initial:
                loadMoreBar?.isHidden = false
            case .finite:
                loadMoreBar?.isHidden = true
            case .empty:
                setContentOffset(.init(x: 0, y: 0), animated: true)
                loadMoreBar?.isHidden = true
            case .reloading:
                pageAmount = 0
                loadMoreBar?.isHidden = true
            }
        }
    }
    
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
            insertSubview(reloadBar, at: 0)
            let height = reloadBar.frame.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                reloadBar.frame.size = CGSize(width: reloadBar.frame.width, height: height)
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
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
    
}

import UIKit
