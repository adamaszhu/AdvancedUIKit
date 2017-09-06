/// ImagePickerHelper+CameraHelperDelegate implements the result of authorization camera.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
extension ImagePickerHelper: CameraHelperDelegate {
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeCamera result: Bool) {
        if result {
            showImageViewController(withSourceType: .camera)
        } else {
            cameraHelper.requestCameraAuthorization()
        }
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeLibrary result: Bool) {
        if result {
            showImageViewController(withSourceType: .photoLibrary)
        } else {
            cameraHelper.requestLibraryAuthorization()
        }
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didCatchError error: String) {
        imagePickerHelperDelegate?.imagePickerHelper(self, didCatchError: error)
    }
    
}

import UIKit
