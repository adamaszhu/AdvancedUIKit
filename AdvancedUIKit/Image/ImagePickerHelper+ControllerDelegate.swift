/// ImagePickerHelper+ControllerDelegate provides callback when an image is picked.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// System error.
    private static let imageError = "There has been error while picking the image."
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            Logger.standard.logError(ImagePickerHelper.imageError)
            return
        }
        picker.dismiss(animated: true, completion: nil)
        imagePickerHelperDelegate?.imagePickerHelper(self, didPickImage: image)
    }
    
}

import UIKit
