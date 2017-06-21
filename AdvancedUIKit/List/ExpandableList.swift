//import UIKit
//
///**
// * ExpandableList is a list whose cell can be extended.
// * - version: 0.0.8
// * - date: 23/10/2016
// * - author: Adamas
// */
//public class ExpandableList: UITableView, UITableViewDelegate, UITableViewDataSource {
//    
//    /**
//     * System message.
//     */
//    private static let IdentifierError = "The cell id cannot be found."
//    private static let CellError = "The cell is not an extendable cell."
//    
//    /**
//     * Expanded icon.
//     */
//    public var expandedIcon: UIImage?
//    
//    /**
//     * Collapsed icon.
//     */
//    public var foldedIcon: UIImage?
//    
//    /**
//     * The space between two line
//     */
//    public var lineSpace: CGFloat
//    
//    /**
//     * A list of cell in the list.
//     */
//    public private(set) var cellList: Array<ExpandableListCell>
//    
//    /**
//     * The index of the cell selected.
//     */
//    private var selectedCellIndex: Int?
//    
//    /**
//     * Whether the cell is inserted during the initializing stage or not.
//     */
//    private var isInitialized: Bool
//    
//    /**
//     * Insert a new cell into the list.
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     * - parameter identifier: The reusable identification of the cell.
//     * - parameter item: The item related to the cell.
//     */
//    public func insertCell(withIdentifier identifier: String, withItem item: AnyObject?) {
//        let cell = dequeueReusableCellWithIdentifier(identifier) as? ExpandableListCell
//        if cell == nil {
//            logError(ExpandableList.IdentifierError)
//            return
//        }
//        if !cell!.isKindOfClass(ExpandableListCell) {
//            logError(ExpandableList.CellError)
//            return
//        }
//        cell!.selectionStyle = UITableViewCellSelectionStyle.None
//        cell!.statusIconImage?.image = foldedIcon
//        cell!.item = item
//        cellList.append(cell!)
//        if isInitialized {
//            reloadData()
//        }
//    }
//    
//    /**
//     * Remove all cells in the list.
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func resetList() {
//        cellList.removeAll()
//        reloadData()
//    }
//    
//    /**
//     * Fold all cells.
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func foldAllCells() {
//        if selectedCellIndex != nil {
//            tableView(self, didSelectRowAtIndexPath: NSIndexPath(forRow: selectedCellIndex!, inSection: 0 ))
//        }
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    required public init?(coder aDecoder: NSCoder) {
//        cellList = []
//        isInitialized = false
//        lineSpace = 0
//        super.init(coder: aDecoder)
//        self.dataSource = self
//        self.delegate = self
//        separatorStyle = UITableViewCellSeparatorStyle.None
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        reloadData()
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = cellList[indexPath.row]
//        if (selectedCellIndex == nil) || (selectedCellIndex! != indexPath.row) {
//            cell.detailView?.hidden = true
//            return cell.foldedHeight + lineSpace
//        } else {
//            cell.detailView?.hidden = false
//            return cell.expandedHeight + lineSpace
//        }
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        beginUpdates()
//        let previousSelectedCellIndex = selectedCellIndex
//        selectedCellIndex = indexPath.row
//        if selectedCellIndex == previousSelectedCellIndex {
//            // COMMENT: Click the cell again stands for fold the cell.
//            selectedCellIndex = nil
//        }
//        if previousSelectedCellIndex != nil {
//            cellList[previousSelectedCellIndex!].statusIconImage?.image = foldedIcon
//        }
//        if selectedCellIndex != nil {
//            cellList[selectedCellIndex!].statusIconImage?.image = expandedIcon
//        }
//        endUpdates()
//        if selectedCellIndex != nil {
//            // COMMENT: Show the expanded information.
//            let cell = cellList[selectedCellIndex!]
//            if cell.frame.origin.y + cell.expandedHeight > contentOffset.y + frame.size.height {
//                let newOffset = cell.expandedHeight > frame.size.height ? cell.frame.origin.y : cell.frame.origin.y + cell.expandedHeight - frame.size.height
//                setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
//            }
//        }
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        isInitialized = true
//        return cellList.count
//    }
//    
//    /**
//     * - version: 0.0.8
//     * - date: 23/10/2016
//     */
//    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = cellList[indexPath.row]
//        cell.renderWithItem()
//        cell.localize()
//        return cell
//    }
//    
//}
