#if !os(macOS)
/// ImageView+Measurer is used to scale the image according to the resolution of the image.
///
/// - author: Adamas
/// - date: 18/08/2019
/// - version: 1.5.0
public extension UIImageView {
    
    /// Calculate the real frame if the image within the UIImageView.
    var imageFrame: CGRect? {
        guard let image = image else {
            Logger.standard.logError(Self.imageError)
            return nil
        }
        let imageRatio = image.size.width / image.size.height
        let viewRatio = frame.size.width / frame.size.height
        var imageWidth: CGFloat
        var imageHeight: CGFloat
        switch contentMode {
        case .scaleAspectFit:
            if imageRatio > viewRatio {
                // Fit by width.
                imageHeight = frame.size.width / imageRatio
                imageWidth = frame.size.width
            } else {
                // Fit by height.
                imageWidth = imageRatio * frame.size.height
                imageHeight = frame.size.height
            }
        case .scaleAspectFill:
            if imageRatio > viewRatio {
                // Fit by height.
                imageWidth = imageRatio * frame.size.height
                imageHeight = frame.size.height
            } else {
                // Fit by width.
                imageHeight = frame.size.width / imageRatio
                imageWidth = frame.size.width
            }
        default:
            Logger.standard.logError(Self.contentModeError)
            return nil
        }
        return CGRect(x: frame.origin.x + center.x - imageWidth / 2,
                      y: frame.origin.y + center.y - imageHeight / 2,
                      width: imageWidth,
                      height: imageHeight)
    }
}

/// Constants
private extension UIImageView {
    
    /// System messages.
    static let imageError = "No image has been allocated to the image view yet."
    static let contentModeError = "The content mode has not been supported yet."
}

import AdvancedFoundation
import UIKit
#endif
