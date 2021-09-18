#if !os(macOS)
/// Provide a screenshot function for a scroll view
///
/// - author: Adamas
/// - date: 08/05/2019
/// - version: 1.5.0
public extension UIScrollView {
    
    /// The screenshot created for the view.
    ///
    ///  - Important:
    ///  Since iOS 13, cells out of the view are not persistent in the memory. So UITableView and UICollectionView cannot generate screenshots.
    ///
    /// - Parameter scale: The scale of the screenshot
    /// - Returns: The screenshot
    func contentScreenshot(withScale scale: Double = 1) -> UIImage? {
        guard #available(iOS 13, *) else {
            UIGraphicsBeginImageContextWithOptions(contentSize, isOpaque, CGFloat(scale))
            guard let context = UIGraphicsGetCurrentContext() else {
                Logger.standard.logError(Self.contextError)
                return nil
            }
            let previousFrame = frame
            frame = CGRect(origin: frame.origin, size: contentSize)
            layer.render(in: context)
            frame = previousFrame
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        if self is UITableView || self is UICollectionView {
            Logger.standard.logError(Self.typeError)
            return nil
        }
        if let contentView = subviews.first {
            return contentView.screenshot(withScale: scale)
        } else {
            return nil
        }
    }
}

/// Constants
private extension UIScrollView {
    
    /// System errors
    static let contextError = "Graphics context is nil"
    static let typeError = "Table views and collection views cannot generate screenshots"
}

import AdvancedFoundation
import UIKit
#endif
