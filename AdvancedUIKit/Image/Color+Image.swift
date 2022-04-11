/// Render an image using a given color
///
/// - author: Adamas
/// - date: 11/04/2022
/// - version: 1.9.0
public extension UIColor {
    
    /// Generate an image with the given color.
    ///
    /// - Important:
    /// If `size` is `.zero`, the size of the generated image will be minimized to `CGSize(width: 1, height: 1)` to avoid weird rendering behavior.
    ///
    /// - Parameter size: The size of the image.
    /// - Returns: The generated image.
    func image(with size: CGSize) -> UIImage {
        let size = size == .zero ? Self.defaultSize : size
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

/// Constants
private extension UIColor {
    static var defaultSize: CGSize { .init(width: 1, height: 1) }
}

import UIKit
