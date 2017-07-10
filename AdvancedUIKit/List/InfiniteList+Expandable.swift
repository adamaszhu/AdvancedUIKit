/// InfiniteList+Expandable implements the function related to expanding and collapsing.
/// - author: Adamas
/// - version: 1.0.0
/// - date: 03/07/2017
public extension InfiniteList {
    
    /// System warnings.
    private static let cellExpansionWarning = "The cell cannot be expanded."
    private static let cellCollapsionWarning = "The cell cannot be collapsed."
    private static let contentOffsetAdjustionError = "The content offset cannot be adjusted."
    
    /// Expand a specific cell.
    ///- parameter index: The index of the cell.
    public func expandCell(atIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellExpansionWarning, withDetail: index)
            return
        }
        cell.expand()
        expandedCellIndexPath = indexPath
        adjustContentOffset()
    }
    
    /// Collapse a specific cell.
    /// - parameter index: The index of the cell.
    public func collapseCell(atIndex index: Int) {
        let index = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: index) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellCollapsionWarning, withDetail: index)
            return
        }
        cell.collapse()
        expandedCellIndexPath = nil
    }
    
    /// Collapse all cells.
    public func collapseAllCells() {
        guard let index = expandedCellIndexPath?.row else {
            Logger.standard.logWarning(InfiniteList.cellCollapsionWarning)
            return
        }
        collapseCell(atIndex: index)
    }
    
    /// Adjust the content offset to fit the expanded cell.
    private func adjustContentOffset() {
        guard let indexPath = expandedCellIndexPath else {
            Logger.standard.logError(InfiniteList.contentOffsetAdjustionError)
            return
        }
        guard let item = items.element(atIndex: indexPath.row), let cellType = cellType(for: item.type) else {
            return
        }
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.contentOffsetAdjustionError)
            return
        }
        if cell.frame.origin.y < contentOffset.y {
            setContentOffset(.init(x: 0, y: cell.frame.origin.y), animated: true)
            return
        }
        if cell.frame.origin.y + cellType.height > contentOffset.y + frame.height {
            let newOffset = cellType.height > frame.size.height ? cell.frame.origin.y : cell.frame.origin.y + cellType.height - frame.height
            setContentOffset(.init(x: 0, y: newOffset), animated: true)
        }
    }
    
}

import UIKit
