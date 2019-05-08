/// Provide a screenshot function for any view
///
/// - author: Adamas
/// - date: 22/08/2018
/// - version: 1.4.0
public extension UIView {
    
    /// System error.
    private static let contextError = "The graphic context is nil."
    
    /// The screenshot created for the view.
    public func screenshot(withScale scale: Double = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, CGFloat(scale))
        guard let context = UIGraphicsGetCurrentContext() else {
            Logger.standard.logError(UIView.contextError)
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

import UIKit
