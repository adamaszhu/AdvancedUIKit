/**
 * The picker action has been finished.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public protocol ImagePickerHelperDelegate {
    
    /**
     * The image has been picked.
     * - parameter image: The image picked.
     */
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPickImage image: UIImage)
    
}

import UIKit
