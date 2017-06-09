//import UIKit
//
///**
// * ImagePickerHelper is used to select an image in the image library or using the camera.
// * - version: 0.0.2
// * - date: 14/11/2016
// * - author: Adamas
// */
//public class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//    /**
//     * The delegate.
//     */
//    public var imagePickerHelperDelegate: ImagePickerHelperDelegate?
//    
//    /**
//     * The view controller that the picker belongs to.
//     */
//    private var viewController: UIViewController
//    
//    /**
//     * Initialize the helper.
//     * - version: 0.0.1
//     * - date: 09/10/2016
//     * - parameter viewController: The view controller where the image picker will be launched from.
//     */
//    public init(withViewController viewController: UIViewController) {
//        self.viewController = viewController
//        super.init()
//    }
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
//    /**
//     * Show the image view controller with a specific type.
//     * - version: 0.0.1
//     * - date: 09/10/2016
//     * - parameter type: The type of the image view controller.
//     */
//    private func showImageViewController(withSourceType type:UIImagePickerControllerSourceType) {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = type;
//        imagePickerController.delegate = self;
//        self.viewController.navigationController?.presentViewController(imagePickerController, animated: true, completion: nil)
//    }
//    
//    /**
//     * An image has been picked.
//     * - version: 0.0.1
//     * - date: 09/10/2016
//     */
//    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        if image == nil {
//            logError(ImagePickerHelper.ImageError)
//            return
//        }
//        imagePickerHelperDelegate?.imagePickerHelper(self, didPickImage: image!)
//    }
//}
