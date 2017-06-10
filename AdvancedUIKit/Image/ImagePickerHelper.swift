/**
 * ImagePickerHelper is used to select an image in the image library or using the camera.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public class ImagePickerHelper: NSObject {//, UINavigationControllerDelegate {
//
//    /**
//     * The content on the selector.
//     */
//    private static let SelectFromLibrary = "SelectFromLibrary"
//    private static let TakePhoto = "TakePhoto"
//    private static let Cancel = "Cancel"
//    private static let CameraAuthorizationError = "CameraAuthorizationError"
//    
//    /**
//     * System error.
//     */
//    private static let ImageError = "There has been error while picking the image."
//    
    /**
     * The delegate.
     */
    public var imagePickerHelperDelegate: ImagePickerHelperDelegate?
    
    /**
     * The application used to do the action.
     */
    private let application: UIApplication
    
    /**
     * Initialize the object.
     * - parameter application: The application used to make a function call.
     */
    public init(application: UIApplication = UIApplication.shared) {
        self.application = application
        super.init()
    }
//    
//    /**
//     * Show the image picker selector.
//     * - version: 0.0.2
//     * - date: 14/11/2016
//     */
//    public func showImagePicker() {
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
//        let selectFromLibraryAction = UIAlertAction(title: ImagePickerHelper.SelectFromLibrary.localizeInBundle(forClass: self.classForCoder), style: .Default) { (action: UIAlertAction) in
//            self.showImageViewController(withSourceType: .PhotoLibrary)
//        }
//        let takePhotoAction = UIAlertAction(title: ImagePickerHelper.TakePhoto.localizeInBundle(forClass: self.classForCoder), style: .Default) { (action: UIAlertAction) in
//            if !CameraHelper.isCameraAuthorized {
//                MessageHelper.defaultHelper.showError(withContent: ImagePickerHelper.CameraAuthorizationError.localizeInBundle(forClass: self.classForCoder))
//                return
//            }
//            self.showImageViewController(withSourceType: .Camera)
//        }
//        let cancelAction = UIAlertAction(title: ImagePickerHelper.Cancel.localizeInBundle(forClass: self.classForCoder), style: .Default) { (action: UIAlertAction) in
//            self.viewController.dismissViewControllerAnimated(true, completion: nil)
//        }
//        alertController.addAction(selectFromLibraryAction)
//        alertController.addAction(takePhotoAction)
//        alertController.addAction(cancelAction)
//        viewController.presentViewController(alertController, animated: true, completion: nil)
//    }
//    
    /**
     * Show the image view controller with a specific type.
     * - parameter type: The type of the image view controller.
     */
//    private func showImageViewController(withSourceType type: UIImagePickerControllerSourceType) {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = type
//        imagePickerController.delegate = self
//        self.viewController.navigationController?.presentViewController(imagePickerController, animated: true, completion: nil)
//    }

}

import UIKit
