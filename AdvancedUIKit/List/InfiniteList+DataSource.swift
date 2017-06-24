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
        guard let item = items.element(atIndex: indexPath.row)  else {
            return UITableViewCell()
        }
        let cellID = String(describing: item.type)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.cellError, withDetail: cellID)
            return UITableViewCell()
        }
        cell.switchExpandStatusAction = { [unowned self] _ in
            let index = indexPath.row
            self.expandedIndex = self.expandedIndex == index ? nil : index
        }
        cell.render(item.item)
        return cell
    }
    
}

import UIKit
