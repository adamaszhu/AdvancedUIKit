/// ImagePickerHelper is used to select an image in the image library or using the camera.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
final public class ImagePickerHelper: NSObject {
    
    /// The delegate.
    public var imagePickerHelperDelegate: ImagePickerHelperDelegate?
    
    /// The camera authorization helper.
    private let cameraHelper: CameraHelper
    
    /// The current view controller.
    private let currentViewController: UIViewController?
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application used to make a function call.
    public init(application: UIApplication = UIApplication.shared, cameraHelper: CameraHelper = .init()) {
        self.cameraHelper = cameraHelper
        currentViewController = application.rootViewController
        super.init()
        cameraHelper.cameraHelperDelegate = self
    }
    
    /// Show the image picker selector.
    public func showImagePicker() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectFromLibraryActionTitle = ImagePickerHelper.selectFromLibraryActionName.localizedInternalString(forType: self.classForCoder)
        let selectFromLibraryAction = UIAlertAction(title: selectFromLibraryActionTitle, style: .default) { [unowned self] _ in
            guard self.cameraHelper.isLibraryAuthorized else {
                self.cameraHelper.requestLibraryAuthorization()
                return
            }
            self.showImageViewController(of: .photoLibrary)
        }
        let takePhotoActionTitle = ImagePickerHelper.takePhotoActionName.localizedInternalString(forType: self.classForCoder)
        let takePhotoAction = UIAlertAction(title: takePhotoActionTitle, style: .default) { [unowned self] _ in
            guard self.cameraHelper.isCameraAuthorized else {
                self.cameraHelper.requestCameraAuthorization()
                return
            }
            self.showImageViewController(of: .camera)
        }
        let cancelActionTitle = ImagePickerHelper.cancelActionName.localizedInternalString(forType: self.classForCoder)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { [unowned self] _ in
            self.currentViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(selectFromLibraryAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(cancelAction)
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// Show the image view controller with a specific type.
    ///
    /// - Parameter type: The type of the image view controller.
    func showImageViewController(of type: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        currentViewController?.present(imagePickerController, animated: true, completion: nil)
    }
    
}

import UIKit
