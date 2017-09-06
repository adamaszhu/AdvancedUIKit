/// InfiniteList+DataSource implements the data source of UITableView
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 22/06/2017
extension InfiniteList: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let item = items.element(atIndex: index)  else {
            return UITableViewCell()
        }
        let cellID = String(describing: item.type)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InfiniteCell else {
            Logger.standard.log(error: InfiniteList.cellError, withDetail: cellID)
            return UITableViewCell()
        }
        if cell.isExpandable {
            if indexPath == expandedCellIndexPath {
                cell.expand()
            } else {
                cell.collapse()
            }
            cell.switchExpandStatusAction = { [unowned self] _ in
                if self.expandedCellIndexPath == indexPath {
                    self.collapseCell(atIndex: index)
                    return
                }
                if let previousExpandedCellIndex = self.expandedCellIndexPath {
                    // COMMENT: Collapse previous expanded cell.
                    self.collapseCell(atIndex: previousExpandedCellIndex.row)
                }
                self.expandCell(atIndex: index)
            }
        }
        cell.render(withItem: item.item)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch status {
        case .finite, .infinite:
            guard let cell = cellForRow(at: indexPath) as? InfiniteCell else {
                return false
            }
            // Comment: If a cell can be expanded, it should implement those editable feature in the additional view.
            return isEditable && !cell.isExpandable
        default:
            return false
        }
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard status.isEditionAvailable, let item = items.element(atIndex: indexPath.row)?.item else {
                return
            }
            items.remove(at: indexPath.row)
            if items.count != 0 {
                deleteRows(at: [indexPath], with: .automatic)
            } else {
                status = .empty
            }
            reloadData()
            loadingMoreBar?.frame.origin = .init(x: 0, y: contentSize.height)
            infiniteListDelegate?.infiniteList(self, didDeleteItem: item)
        default:
            break
        }
    }
    
}

import UIKit
