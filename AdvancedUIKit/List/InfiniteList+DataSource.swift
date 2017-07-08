/**
 * InfiniteList+DataSource implements the data source of UITableView
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/06/2017
 */
extension InfiniteList: UITableViewDataSource {
    
    /**
     * UITableViewDataSource
     */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /**
     * UITableViewDataSource
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let item = items.element(atIndex: index)  else {
            return UITableViewCell()
        }
        let cellID = String(describing: item.type)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.cellError, withDetail: cellID)
            return UITableViewCell()
        }
        if cell.isExpandable {
            if indexPath == expandedCellIndex {
                cell.expand()
            } else {
                cell.collapse()
            }
            cell.switchExpandStatusAction = { [unowned self] _ in
                if self.expandedCellIndex == indexPath {
                    self.collapseCell(atIndex: index)
                    return
                }
                if let previousExpandedCellIndex = self.expandedCellIndex {
                    // COMMENT: Collapse previous expanded cell.
                    self.collapseCell(atIndex: previousExpandedCellIndex.row)
                }
                self.expandCell(atIndex: index)
            }
        }
        cell.render(item.item)
        return cell
    }
    
}

import UIKit
