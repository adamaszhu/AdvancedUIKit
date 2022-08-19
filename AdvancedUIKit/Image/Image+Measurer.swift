
public extension UIImage {

    /// Get the size of a network image without loading it into the memory
    ///
    /// - Parameter url: The url representing where the image is .
    /// - Returns: The size of the image. Nil if there is no image at the given URL.
    static func sizeOfImage(at url: URL) -> CGSize? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }
        let propertyOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertyOptions) as? [CFString: Any] else {
            return nil
        }
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
}

import UIKit
