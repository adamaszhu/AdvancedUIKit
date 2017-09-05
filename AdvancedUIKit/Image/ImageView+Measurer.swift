/// ImageView+Measurer is used to scale the image according to the resolution of the image.
///
/// - author: Adamas
/// - date: 23/10/2016
/// - version: 1.0.0
public extension UIImageView {
    
    /// System messages.
    private static let imageError = "No image has been allocated to the image view yet."
    private static let contentModeError = "The content mode has not been supported yet."
    
    /// Calculate the real frame if the image within the UIImageView.
    public var imageFrame: CGRect? {
        guard let image = image else {
            Logger.standard.logError(UIImageView.imageError)
            return nil
        }
        let imageRatio = image.size.width / image.size.height
        let viewRatio = frame.size.width / frame.size.height
        var imageWidth: CGFloat
        var imageHeight: CGFloat
        switch contentMode {
        case .scaleAspectFit:
            if imageRatio > viewRatio {
                // COMMENT: Fit by width.
                imageHeight = frame.size.width / imageRatio
                imageWidth = frame.size.width
            } else {
                // COMMENT: Fit by height.
                imageWidth = imageRatio * frame.size.height
                imageHeight = frame.size.height
            }
        case .scaleAspectFill:
            if imageRatio > viewRatio {
                // COMMENT: Fit by height.
                imageWidth = imageRatio * frame.size.height
                imageHeight = frame.size.height
            } else {
                // COMMENT: Fit by width.
                imageHeight = frame.size.width / imageRatio
                imageWidth = frame.size.width
            }
        default:
            // TODO: Support more modes.
            Logger.standard.logError(UIImageView.contentModeError)
            return nil
        }
        return CGRect(x: frame.origin.x + center.x - imageWidth / 2, y: frame.origin.y + center.y - imageHeight / 2, width: imageWidth, height: imageHeight)
    }
    
}

import UIKit
