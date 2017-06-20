/**
 * ImagePickerHelper is used to select an image in the image library or using the camera.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public class ImagePickerHelper: NSObject {
    
    /**
     * The content on the selector.
     */
    private static let selectFromLibraryActionName = "SelectFromLibrary"
    private static let takePhotoActionName = "TakePhoto"
    private static let cancelActionName = "Cancel"
    
    /**
     * The delegate.
     */
    public var imagePickerHelperDelegate: ImagePickerHelperDelegate?
    
    /**
     * The camera authorization helper.
     */
    private let cameraHelper: CameraHelper
    
    /**
     * The current view controller.
     */
    private let currentViewController: UIViewController?
    
    /**
     * Initialize the object.
     * - parameter application: The application used to make a function call.
     */
    public init(application: UIApplication = UIApplication.shared, cameraHelper: CameraHelper = CameraHelper()) {
        self.cameraHelper = cameraHelper
        currentViewController = application.rootViewController
        super.init()
        cameraHelper.cameraHelperDelegate = self
    }
    
    /**
     * Show the image picker selector.
     */
    public func showImagePicker() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectFromLibraryActionTitle = ImagePickerHelper.selectFromLibraryActionName.localizeWithinFramework(forType: self.classForCoder)
        let selectFromLibraryAction = UIAlertAction(title: selectFromLibraryActionTitle, style: .default) { [unowned self] _ in
            guard CameraHelper.isLibraryAuthorized else {
                self.cameraHelper.requestLibraryAuthorization()
                return
            }
            self.showImageViewController(withSourceType: .photoLibrary)
        }
        let takePhotoActionTitle = ImagePickerHelper.takePhotoActionName.localizeWithinFramework(forType: self.classForCoder)
        let takePhotoAction = UIAlertAction(title: takePhotoActionTitle, style: .default) { [unowned self] _ in
            guard CameraHelper.isCameraAuthorized else {
                self.cameraHelper.requestCameraAuthorization()
                return
            }
            self.showImageViewController(withSourceType: .camera)
        }
        let cancelActionTitle = ImagePickerHelper.cancelActionName.localizeWithinFramework(forType: self.classForCoder)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { [unowned self] _ in
            self.currentViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(selectFromLibraryAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(cancelAction)
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Show the image view controller with a specific type.
     * - parameter type: The type of the image view controller.
     */
    func showImageViewController(withSourceType type: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        currentViewController?.present(imagePickerController, animated: true, completion: nil)
    }
    
}

import UIKit
