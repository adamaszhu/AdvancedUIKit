//import UIKit
//
///**
// * ExpandableListCell is used to maintain a cell that can be extended.
// * - version: 0.0.4
// * - date: 24/10/2016
// * - author: Adamas
// */
//public class ExpandableListCell: UITableViewCell {
//    
//    /**
//     * The icon used to show whether current cell is expanded or not.
//     */
//    @IBOutlet weak var statusIconImage: UIImageView?
//    
//    /**
//     * The expand title.
//     */
//    @IBOutlet weak var titleView: UIView!
//    
//    /**
//     * The expand detail.
//     */
//    @IBOutlet weak var detailView: UIView?
//    
//    /**
//     * The item that the cell is displaying.
//     */
//    public var item: AnyObject?
//    
//    /**
//     * The height after the cell is extended.
//     * - version: 0.0.4
//     * - date: 24/10/2016
//     */
//    public var expandedHeight: CGFloat {
//        get {
//            if titleView == nil {
//                titleView = contentView
//            }
//            if expandedHeightValue < 0 {
//                let detailHeight = detailView == nil ? 0 : detailView!.frame.size.height
//                expandedHeightValue = detailHeight + titleView.frame.size.height
//            }
//            return expandedHeightValue
//        }
//    }
//    
//    /**
//     * The height when the cell is folded.
//     * - version: 0.0.4
//     * - date: 24/10/2016
//     */
//    public var foldedHeight: CGFloat {
//        get {
//            if titleView == nil {
//                titleView = contentView
//            }
//            if foldedHeightValue < 0 {
//                foldedHeightValue = titleView.frame.size.height
//            }
//            return foldedHeightValue
//        }
//    }
//    
//    /**
//     * The folded height value.
//     */
//    private var foldedHeightValue: CGFloat
//    
//    /**
//     * The expanded height value.
//     */
//    private var expandedHeightValue: CGFloat
//    
//    /**
//     * Render the cell according to the item. This function should be overrided.
//     * - version: 0.0.4
//     * - date: 24/10/2016
//     */
//    public func renderWithItem() {
//    }
//    
//    /**
//     * - version: 0.0.4
//     * - date: 24/10/2016
//     */
//    required public init?(coder aDecoder: NSCoder) {
//        foldedHeightValue = -1
//        expandedHeightValue = -1
//        super.init(coder: aDecoder)
//        clipsToBounds = true
//    }
//    
//}
