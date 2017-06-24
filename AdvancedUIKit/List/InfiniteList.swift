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
    static let cellError = "The cell has not been registered yet."
    
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
     * Reload a list of items.
     * - parameter items: The items to be reloaded.
     */
    public func reload(_ items: Array<InfiniteItem>) {
        self.items = items
        reloadData()
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
        Logger.standard.logError(InfiniteList.cellError, withDetail: type)
        return nil
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
