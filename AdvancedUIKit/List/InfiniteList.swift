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
    static let nibError = "The nib file containing the customized InfiniteCell has not been registered yet."
    static let indexError = "Unknown cell index is detected."
    
    /**
     * Delegate
     */
    public var infiniteListDelegate: InfiniteListDelegate?
    
    /**
     * The items displayed on the screen.
     */
    var items: Array<InfiniteItem>
    
    /**
     * Reload a list of items.
     * - parameter items: The items to be reloaded.
     */
    public func reload(_ items: Array<InfiniteItem>) {
        self.items = items
        reloadData()
    }
    
    /**
     * Define the nib file used to render an item cell.
     * - parameter nib: The nib file.
     * - parameter cell: The item cell.
     */
    public func register(_ nib: UINib, for cellType: InfiniteCell.Type) {
        register(nib, forCellReuseIdentifier: String(describing: cellType))
    }
    
    /**
     * UITableView
     */
    public required init?(coder aDecoder: NSCoder) {
        items = []
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
    
}

import Foundation
import UIKit
