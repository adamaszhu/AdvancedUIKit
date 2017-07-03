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
    
    /**
     * System warning.
     */
    static let expandWarning = "The cell cannot be expanded."
    static let collapseWarning = "The cell cannot be collapsed."
    static let emptyStateShowingWarning = "The empty state has already been shown."
    static let emptyStateHidingWarning = "The empty state has already been hidden"
    
    /**
     * The minimal page size.
     */
    static let minPageSize = 5
    
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
     * The index of cell that is currently expanded.
     */
    var expandedCellIndex: IndexPath? {
        didSet {
            beginUpdates()
            endUpdates()
        }
    }
    
    /**
     * Expand a specific cell.
     * - parameter index: The index of the cell.
     */
    public func expandCell(atIndex index: Int) {
        let index = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: index) as? InfiniteCell else {
            // Comment: The cell is not visible.
            return
        }
        guard cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.expandWarning, withDetail: index)
            return
        }
        cell.expand()
        expandedCellIndex = index
        adjustContentOffset()
    }
    
    /**
     * Collapse a specific cell.
     * - parameter index: The index of the cell.
     */
    public func collapseCell(atIndex index: Int) {
        let index = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: index) as? InfiniteCell else {
            // Comment: The cell is not visible.
            return
        }
        guard cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.collapseWarning, withDetail: index)
            return
        }
        cell.collapse()
        expandedCellIndex = nil
    }
    
    /**
     * Collapse all cells.
     */
    public func collapseAllCells() {
        guard let index = expandedCellIndex?.row else {
            return
        }
        collapseCell(atIndex: index)
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
            showEmptyState()
        } else {
            hideEmptyState()
        }
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
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.emptyStateError)
            return
        }
        view.frame = bounds
        emptyState = view
    }
    
    /**
     * Register the load more view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerLoadMoreBar(_ nib: UINib) {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.loadMoreBarError)
            return
        }
        loadMoreBar = view
    }
    
    /**
     * Register the reload view for the InfiniteList.
     * - parameter nib: The nib file containing the view.
     */
    public func registerReloadBar(_ nib: UINib) {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.reloadBarError)
            return
        }
        reloadBar?.removeFromSuperview()
        view.frame = .init(x: 0, y: -view.frame.height, width: frame.width, height: view.frame.height)
        addSubview(view)
        reloadBar = view
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
        isScrollEnabled = false
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
        isScrollEnabled = true
        emptyState.animate(withChange: {
            emptyState.alpha = 0
        }, withPreparation: {
            emptyState.alpha = 1
        }, withCompletion: {
            emptyState.removeFromSuperview()
        })
    }
    
    /**
     * Adjust the content offset to fit the expanded cell.
     */
    private func adjustContentOffset() {
        guard let index = expandedCellIndex, let item = items.element(atIndex: index.row), let cellType = cellType(for: item.type) else {
            return
        }
        guard let cell = cellForRow(at: index) as? InfiniteCell, cell.isExpandable, let additionalHeight = cellType.additionalHeight else {
            Logger.standard.logError(InfiniteList.cellError)
            return
        }
        if cell.frame.origin.y + additionalHeight + cellType.height > contentOffset.y + frame.height {
            let newOffset = additionalHeight > frame.size.height ? cell.frame.origin.y : cell.frame.origin.y + additionalHeight + cellType.height - frame.height
            setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
            return
        }
        if cell.frame.origin.y < contentOffset.y {
            setContentOffset(CGPoint(x: 0, y: cell.frame.origin.y), animated: true)
        }
    }
    
    /**
     * UITableView
     */
    public required init?(coder aDecoder: NSCoder) {
        items = []
        cellTypes = []
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
    
}

import Foundation
import UIKit
