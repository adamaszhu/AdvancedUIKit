#if !os(macOS) && !targetEnvironment(macCatalyst)
#if PHOTO
/// The picker action has been finished.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
public protocol ImagePickerHelperDelegate: AnyObject {
    
    /// The image has been picked.
    ///
    /// - Parameter image: The image picked.
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didPick image: UIImage)
    
    /// An error occurs.
    ///
    /// - Parameter error: The detail of the error.
    func imagePickerHelper(_ imagePickerHelper: ImagePickerHelper, didCatchError error: String)
}
#endif

import UIKit
#endif
