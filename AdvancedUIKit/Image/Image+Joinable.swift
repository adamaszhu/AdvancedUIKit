/// Join images into one
///
/// - author: Adamas
/// - date: 08/05/2019
/// - version: 1.5.0
public extension UIImage {
    
    /// Concat two images.
    ///
    /// - Parameters:
    ///   - image: The second image.
    ///   - direction: Concat direction.
    /// - Returns: The new image.
    func concat(_ image: UIImage, with direction: ImageJoinDirection) -> UIImage? {
        let width: CGFloat
        let height: CGFloat
        switch direction {
        case .horizontalTop:
            width = image.size.width + self.size.width
            height = max(image.size.height, self.size.height)
        case .verticalLeft:
            width = max(image.size.width, self.size.width)
            height = image.size.height + self.size.height
        }
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: self.size))
        
        // Draw the second image
        let concatOrigin: CGPoint
        switch direction {
        case .horizontalTop:
            concatOrigin = CGPoint(x: self.size.width, y: 0)
        case .verticalLeft:
            concatOrigin = CGPoint(x: 0, y: self.size.height)
        }
        image.draw(in: CGRect(origin: concatOrigin, size: image.size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

import UIKit
