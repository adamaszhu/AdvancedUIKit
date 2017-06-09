import UIKit

/**
 * The picker action has been finished.
 * - version: 0.0.1
 * - date: 09/10/2016
 * - author: Adamas
 */
@objc public protocol ImagePickerHelperDelegate {
    
    /**
     * The image has been picked.
     * - version: 0.0.1
     * - date: 09/10/2016
     * - parameter image: The image picked.
     */
    func imagePickerHelper(imagePickerHelper: ImagePickerHelper, didPickImage image: UIImage)
    
}
