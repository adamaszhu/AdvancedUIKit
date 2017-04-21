/**
 * Label+Dynamic contains dynamic content of a label.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 22/04/2017
 */
public extension UILabel {
    
//    /**
//     * The default line space.
//     */
//    private static let DefaultLineSpace = CGFloat(5)
//    
//    /**
//     * Get the position of the end.
//     */
//    public var endPosition: CGPoint {
//        /**
//         * - version: 0.2.0
//         * - date: 12/01/2017
//         */
//        get {
//            if (frame.size.width == 0) || (text == nil) {
//                return frame.origin
//            }
//            let lineList = text!.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
//            if lineList.last == nil {
//                return frame.origin
//            }
//            let size = NSString(string: lineList.last!).sizeWithAttributes([NSFontAttributeName: font])
//            let lastLineLength = size.width % frame.size.width
//            let x = lastLineLength == 0 ? frame.size.width : lastLineLength
//            let y = lastLineLength == 0 ? frame.size.height - lineHeight * 2 - UILabel.DefaultLineSpace : frame.size.height - lineHeight
//            return CGPoint(x: frame.origin.x + x, y: frame.origin.y + y)
//        }
//    }
//    
//    /**
//     * Get the height of each line.
//     */
//    public var lineHeight: CGFloat {
//        /**
//         * - version: 0.0.6
//         * - date: 10/10/2016
//         */
//        get {
//            if text == nil {
//                return 0
//            }
//            return getLineHeight(withText: text!, withFont: font)
//        }
//    }
//    
//    /**
//     * How many lines are presented.
//     */
//    public var lineAmount: Int {
//        /**
//         * - version: 0.0.6
//         * - date: 10/10/2016
//         */
//        get {
//            if text == nil {
//                return 0
//            }
//            return getLineAmount(withText: text!, withFont: font)
//        }
//    }
//    
//    /**
//     * Set the dynamic content.
//     * - version: 0.2.0
//     * - date: 12/01/2017
//     * - parameter text: The content of the label.
//     */
//    public func setDynamicText(text: String) {
//        self.text = text
//        let height = (lineHeight + UILabel.DefaultLineSpace) * CGFloat(lineAmount) - UILabel.DefaultLineSpace
//        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height)
//    }
    
}

import UIKit


