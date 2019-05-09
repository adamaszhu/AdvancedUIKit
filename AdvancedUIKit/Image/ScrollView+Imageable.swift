/// Provide a screenshot function for a scroll view
///
/// - author: Adamas
/// - date: 08/05/2019
/// - version: 1.5.0
public extension UIScrollView {
    
    /// The screenshot created for the view.
    ///
    /// - Parameter scale: The scale of the screenshot
    /// - Returns: The screenshot
    public func contentScreenshot(withScale scale: Double = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, isOpaque, CGFloat(scale))
        guard let context = UIGraphicsGetCurrentContext() else {
            Logger.standard.logError(UIScrollView.contextError)
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
}

/// Constants
private extension UIScrollView {
    
    /// System errors
    static let contextError = "Graphics context is nil"
}

import UIKit
