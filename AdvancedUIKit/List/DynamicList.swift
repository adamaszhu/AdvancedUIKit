
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
//    
//    /**
//     * The height of the item cell.
//     */
//    public var itemCellHeight: CGFloat
//    //
//    
//    /**
//     * Whether there are unloaded item or not.
//     */
//    private var hasMoreItem: Bool
//    
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
//    
//    

//    

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
//    
//
