/// Provide a screenshot function for any view
///
/// - author: Adamas
/// - date: 08/05/2019
/// - version: 1.5.0
public extension UIView {
    
    /// The screenshot created for the view.
    ///
    /// - Parameter scale: The scale of the screenshot
    /// - Returns: The screenshot
    func screenshot(withScale scale: Double = 1) -> UIImage? {
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

/// Constants
private extension UIView {
    
    /// System error.
    static let contextError = "The graphic context is nil."
}

import AdvancedFoundation
import UIKit
