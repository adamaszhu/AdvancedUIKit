/**
 * InfiniteList+Expandable implements the function related to expanding and collapsing.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 03/07/2017
 */
public extension InfiniteList {
    
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
    
}

import UIKit
