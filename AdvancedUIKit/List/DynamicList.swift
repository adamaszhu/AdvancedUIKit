//import UIKit
//
///**
// * DynamicList is a customized list with reload and load more functions.
// * - version: 0.1.0
// * - date: 17/11/2016
// * - author: Adamas
// */
//public class DynamicList: UITableView, UITableViewDataSource, UITableViewDelegate {
//    
//    
//    /**
//     * The id of the cell that will be reused.
//     */
//    private static let ItemListCellId = "ItemCell"
//    private static let ReloadListCellId = "ReloadCell"
//    private static let NoResultListCellId = "NoResultCell"
//    private static let LoadMoreListCellId = "LoadMoreCell"
//    
//    /**
//     * Error messages.
//     */
//    private static let StatusError = "The status is invalid."
//    
//    /**
//     * The delegate of the list.
//     */
//    public var dynamicListDelegate: DynamicListDelegate?
//    
//    /**
//     * Whether load more action is allowed or not.
//     */
//    public var shouldLoadMore: Bool
//    
//    /**
//     * Whether drag and reload function is allowed or not.
//     */
//    public var shouldReload: Bool
//    
//    /**
//     * Whether the list can be edited or not.
//     */
//    public var shouldEdit: Bool
//    
//    /**
//     * The height of the item cell.
//     */
//    public var itemCellHeight: CGFloat
//    
//    /**
//     * The items displayed.
//     */
//    public private(set) var itemList: Array<AnyObject>
//    
//    /**
//     * The status of the list.
//     */
//    private var status: DynamicListStatus
//    
//    /**
//     * Whether there are unloaded item or not.
//     */
//    private var hasMoreItem: Bool
//    
//    /**
//     * The page amount.
//     */
//    private var pageCount: Int
//    
//    /**
//     * The size of each page.
//     */
//    private var pageSize: Int
//    
//    /**
//     * The amount of rows in the list.
//     */
//    private var rowAmount: Int
//    
//    /**
//     * The height of the loading cell.
//     */
//    private var reloadCellHeight: CGFloat
//    
//    /**
//     * The height of the load more cell.
//     */
//    private var loadMoreCellHeight: CGFloat
//    
//    /**
//     * The height of the no result cell.
//     */
//    private var noResultCellHeight: CGFloat
//    
//    /**
//     * Reload the list.
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     * - parameter itemList: The list to be reload.
//     */
//    public func reloadList(itemList: Array<AnyObject>) {
//        self.itemList.removeAll()
//        for item in itemList {
//            self.itemList.append(item)
//        }
//        switch status {
//        case .Initial, .Reloading:
//            if shouldLoadMore {
//                hasMoreItem = itemList.count < DynamicList.MinPageSize ? false : true
//            } else {
//                hasMoreItem = false
//            }
//            pageCount = 1
//            pageSize = hasMoreItem ? itemList.count : DynamicList.MinPageSize
//            reloadData()
//            stopReloading()
//        case .LoadingMore, .Idle:
//            logError(DynamicList.StatusError)
//        }
//    }
//    
//    /**
//     * Append a list to the end of the item list.
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     * - parameter itemList: The list to be appended.
//     */
//    public func appendList(itemList: Array<AnyObject>) {
//        switch status {
//        case .LoadingMore:
//            for item in itemList {
//                self.itemList.append(item)
//            }
//            status = DynamicListStatus.Idle
//            // COMMENT: Not enough new items found.
//            if itemList.count < pageSize {
//                hasMoreItem = false
//            }
//            pageCount += 1
//            reloadData()
//        case .Initial, .Reloading, .Idle:
//            logError(DynamicList.StatusError)
//        }
//    }
//    
//    /**
//     * The list should go into reload mode.
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func startReloading() {
//        switch status {
//        case .Initial, .Reloading:
//            break
//        case .LoadingMore, .Idle:
//            // COMMENT: Display the loading cell.
//            status = DynamicListStatus.Reloading
//            reloadData()
//            setContentOffset(CGPointMake(0, reloadCellHeight), animated: false)
//            UIView.animate(withChange: {
//                self.contentOffset = CGPointMake(0, 0)
//            })
//        }
//    }
//    
//    /**
//     * Stop reloading status.
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    private func stopReloading() {
//        switch status {
//        case .Idle, .LoadingMore:
//            logError(DynamicList.StatusError)
//        case .Initial, .Reloading:
//            UIView.animate(withChange: { () -> Void in
//                self.setContentOffset(CGPointMake(0, self.reloadCellHeight - 1), animated: false)
//                }, withCompletionHandle: {
//                    self.status = DynamicListStatus.Idle
//                    self.reloadData()
//                    self.contentOffset = CGPointMake(0, 0)
//            })
//        }
//    }
//    
//    /**
//     * Start the loading animation in a view.
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     * - parameter view: The view that the operation will be operated on.
//     */
//    private func startActivityIndicatorAnimation(inView view: UIView) {
//        for subview in view.subviews {
//            if subview.isKindOfClass(UIActivityIndicatorView) {
//                (subview as! UIActivityIndicatorView).startAnimating()
//            } else if subview.subviews.count != 0 {
//                startActivityIndicatorAnimation(inView: subview)
//            }
//        }
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    required public init?(coder aDecoder: NSCoder) {
//        itemList = []
//        status = DynamicListStatus.Initial
//        hasMoreItem = false
//        pageCount = 0
//        pageSize = 0
//        shouldLoadMore = true
//        shouldReload = true
//        reloadCellHeight = -1
//        loadMoreCellHeight = -1
//        noResultCellHeight = -1
//        itemCellHeight = -1
//        rowAmount = 0
//        shouldEdit = false
//        super.init(coder: aDecoder)
//        self.dataSource = self
//        self.delegate = self
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        switch status {
//        case .Idle:
//            if itemList.count != 0 {
//                dynamicListDelegate?.dynamicList?(self, didSelectItem: itemList[indexPath.row])
//            }
//        case .Initial, .Reloading, .LoadingMore:
//            logError(DynamicList.StatusError)
//        }
//        return indexPath
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        switch status {
//        case .Idle:
//            if ((indexPath.row == rowAmount - 1) && hasMoreItem) {
//                // COMMENT: Fetch next page
//                status = DynamicListStatus.LoadingMore
//                dynamicListDelegate?.dynamicList?(self, didRequireLoadMore: pageCount)
//            }
//        case .Initial, .Reloading, .LoadingMore:
//            break
//        }
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return shouldEdit
//    }
//    
//    /**
//     * - version: 0.1.0
//     * - date: 17/11/2016
//     */
//    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        switch editingStyle {
//        case .Delete:
//            let item = itemList[indexPath.row]
//            itemList.removeAtIndex(indexPath.row)
//            if itemList.count != 0 {
//                deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//            } else {
//                reloadData()
//                editing = false;
//            }
//            // TODO: Delay the call.
//            dynamicListDelegate?.dynamicList?(self, didDeleteItem: item)
//        default:
//            break
//        }
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if reloadCellHeight == -1 {
//            // COMMENT: Calculate the height of each cell.
//            var cell: UITableViewCell?
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ReloadListCellId)
//            reloadCellHeight = cell == nil ? 0 : cell!.frame.size.height
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.NoResultListCellId)
//            noResultCellHeight = cell == nil ? 0 : cell!.frame.size.height
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ItemListCellId)
//            itemCellHeight = cell == nil ? 0 : cell!.frame.size.height
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.LoadMoreListCellId)
//            loadMoreCellHeight = cell == nil ? 0 : cell!.frame.size.height
//        }
//        switch status {
//        case .Initial:
//            return reloadCellHeight
//        case .Reloading:
//            if indexPath.row == 0 {
//                return reloadCellHeight
//            } else if itemList.count == 0 {
//                return noResultCellHeight
//            } else {
//                return itemCellHeight
//            }
//        case .Idle, .LoadingMore:
//            if itemList.count == 0 {
//                return noResultCellHeight
//            } else if ((indexPath.row == rowAmount - 1) && hasMoreItem) {
//                return loadMoreCellHeight
//            } else {
//                return itemCellHeight
//            }
//            
//        }
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let count = itemList.count == 0 ? 1 : itemList.count
//        switch status {
//        case .Initial:
//            rowAmount = 1
//        case .Reloading:
//            rowAmount = count + 1
//        case .Idle, .LoadingMore:
//            rowAmount = hasMoreItem ? count + 1 : count
//        }
//        return rowAmount
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell: UITableViewCell?
//        var item: AnyObject? = nil
//        switch status {
//        case .Initial:
//            // COMMENT: Add drag reloading banner.
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ReloadListCellId)
//            cell = cell == nil ? UITableViewCell() : cell
//            cell!.localize()
//            cell!.contentView.frame = CGRectMake(0, -cell!.frame.size.height, frame.size.width, cell!.frame.size.height)
//            addSubview(cell!.contentView)
//            cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ReloadListCellId)
//        case .Reloading:
//            if indexPath.row == 0 {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ReloadListCellId)
//            } else if (itemList.count == 0) {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.NoResultListCellId)
//            } else {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ItemListCellId)
//                item = itemList[indexPath.row - 1]
//            }
//        case .Idle, .LoadingMore:
//            if itemList.count == 0 {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.NoResultListCellId)
//            } else if ((indexPath.row == rowAmount - 1) && hasMoreItem) {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.LoadMoreListCellId)
//            } else {
//                cell = tableView.dequeueReusableCellWithIdentifier(DynamicList.ItemListCellId)
//                item = itemList[indexPath.row]
//            }
//        }
//        cell = cell == nil ? UITableViewCell() : cell
//        if item != nil {
//            dynamicListDelegate?.dynamicList(self, didRequireRenderCell: cell!, withItem: item!)
//        }
//        cell!.localize()
//        startActivityIndicatorAnimation(inView: cell!.contentView)
//        return cell!
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if shouldReload {
//            switch status {
//            case .Idle:
//                if scrollView.contentOffset.y == -reloadCellHeight {
//                    scrollView.contentOffset = CGPointMake(0, 0)
//                    status = DynamicListStatus.Reloading
//                    reloadData()
//                    dynamicListDelegate?.dynamicListDidRequireReload?(self)
//                }
//            case .Reloading, .Initial, .LoadingMore:
//                break
//            }
//        }
//    }
//    
//    /**
//     * - version: 0.0.9
//     * - date: 23/10/2016
//     */
//    public func scrollViewDidScroll(scrollView: UIScrollView) {
//        switch status {
//        case .Reloading, .Initial, .LoadingMore:
//            if scrollView.contentOffset.y < 0 {
//                scrollView.contentOffset = CGPointMake(0, 0)
//            }
//        case .Idle:
//            if (shouldReload && (scrollView.contentOffset.y < -reloadCellHeight)) {
//                scrollView.contentOffset = CGPointMake(0, -reloadCellHeight)
//            } else if (!shouldReload && (scrollView.contentOffset.y < 0)) {
//                scrollView.contentOffset = CGPointMake(0, 0)
//            }
//            
//        }
//    }
//    
//}
//
//
