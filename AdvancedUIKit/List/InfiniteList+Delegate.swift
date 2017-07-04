/**
 * InfiniteList+Delegate implements the delegate of UITableView
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/06/2017
 */
extension InfiniteList: UITableViewDelegate {
    
    /**
     * UITableViewDelegate
     */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items.element(atIndex: indexPath.row)  else {
            return
        }
        switch status {
        case .finite, .infinite:
            infiniteListDelegate?.infiniteList(self, didSelectItem: item.item)
        default:
            Logger.standard.logWarning(InfiniteList.selectStatusWarning)
        }
    }
    
    /**
     * UITableViewDelegate
     */
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = items.element(atIndex: indexPath.row), let cellType = cellType(for: item.type)  else {
            return 0
        }
        if indexPath == expandedCellIndex, let additionalHeight = cellType.additionalHeight {
            return cellType.height + additionalHeight
        }
        return cellType.height
    }
    
}

import UIKit
