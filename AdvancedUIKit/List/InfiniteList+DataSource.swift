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
            Logger.standard.logError(InfiniteList.nibError, withDetail: cellID)
            return UITableViewCell()
        }
        cell.render(item.item)
        return cell
    }
    
}

import UIKit
