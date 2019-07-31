/// InfiniteList+Expandable implements the function related to expanding and collapsing.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 03/07/2017
public extension InfiniteList {
    
    /// Expand a specific cell.
    ///
    /// - Parameter index: The index of the cell.
    @objc func expandCell(atIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellExpansionWarning, withDetail: index)
            return
        }
        cell.expand()
        if expandedCellIndexPath == nil, let item = items.element(atIndex: index), let cellType = cellType(for: item.type), let loadingMoreBar = loadingMoreBar {
            // Adjust the loading more bar if a cell has been expanded
            loadingMoreBar.frame.origin = .init(x: 0, y: loadingMoreBar.frame.origin.y + (cellType.additionalHeight ?? 0))
        }
        expandedCellIndexPath = indexPath
        adjustContentOffset(for: cell, at: indexPath)
    }
    
    /// Collapse a specific cell.
    ///
    /// - Parameter index: The index of the cell.
    @objc func collapseCell(atIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellCollapsionWarning, withDetail: index)
            return
        }
        cell.collapse()
        if let _ = expandedCellIndexPath, let item = items.element(atIndex: index), let cellType = cellType(for: item.type), let loadingMoreBar = loadingMoreBar {
            // Adjust the loading more bar if a cell has been collapsed
            loadingMoreBar.frame.origin = .init(x: 0, y: loadingMoreBar.frame.origin.y - (cellType.additionalHeight ?? 0))
        }
        expandedCellIndexPath = nil
    }
    
    /// Collapse all cells.
    @objc func collapseAllCells() {
        guard let index = expandedCellIndexPath?.row else {
            Logger.standard.logWarning(InfiniteList.cellCollapsionWarning)
            return
        }
        collapseCell(atIndex: index)
    }
    
    /// Adjust the content offset to fit the expanded cell.
    ///
    /// - Parameters:
    ///   - cell: The cell that the content offset should be adjusted based on.
    ///   - indexPath: The index of the cell.
    private func adjustContentOffset(for cell: InfiniteCell, at indexPath: IndexPath) {
        guard let item = items.element(atIndex: indexPath.row), let cellType = cellType(for: item.type) else {
            return
        }
        if cell.frame.origin.y < contentOffset.y {
            setContentOffset(.init(x: 0, y: cell.frame.origin.y), animated: true)
        } else if cell.frame.origin.y + cellType.height > contentOffset.y + frame.height {
            let newOffset = cellType.height > frame.size.height ? cell.frame.origin.y : cell.frame.origin.y + cellType.height - frame.height
            setContentOffset(.init(x: 0, y: newOffset), animated: true)
        }
    }
    
}

import UIKit
