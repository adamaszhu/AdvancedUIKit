import UIKit

/**
 * UIImageView+ContentMode is used to scale the image according to the resolution of the image.
 * - author: Adamas
 * - date: 23/10/2016
 * - version: 0.0.2
 */
public extension UIImageView {
    
    /**
     * System messages.
     */
    private static let ImageError = "No image has been allocated to the image view yet."
    private static let ContentModeError = "The content mode has not been supported yet."
    
    /**
     * Calculate the real frame if the image within the UIImageView.
     */
    public var realFrame: CGRect {
        /**
         * - date: 23/10/2016
         * - version: 0.0.2
         */
        get {
            if image == nil {
                logError(UIImageView.ImageError)
                return CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            var imageWidth = image!.size.width
            var imageHeight = image!.size.height
            let viewWidth = frame.size.width
            let viewHeight = frame.size.height
            switch contentMode {
            case .ScaleAspectFit:
                if imageWidth / imageHeight > viewWidth / viewHeight {
                    // COMMENT: Fit by width.
                    imageHeight = imageHeight / imageWidth * viewWidth
                    imageWidth = viewWidth
                } else {
                    // COMMENT: Fit by height.
                    imageWidth = imageWidth / imageHeight * viewHeight
                    imageHeight = viewHeight
                }
            case .ScaleAspectFill:
                if imageWidth / imageHeight > viewWidth / viewHeight {
                    // COMMENT: Fit by height.
                    imageWidth = imageWidth / imageHeight * viewHeight
                    imageHeight = viewHeight
                } else {
                    // COMMENT: Fit by width.
                    imageHeight = viewWidth / imageWidth * imageHeight
                    imageWidth = viewWidth
                }
            default:
                // TODO: Support more modes.
                return CGRect(x: 0,y: 0,width: 0,height: 0)
            }
            return CGRect(x: frame.origin.x + center.x - imageWidth / 2, y: frame.origin.y + center.y - imageHeight / 2, width: imageWidth, height: imageHeight)
        }
    }
    
}
