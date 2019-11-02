#if PHOTO
/// ImagePickerHelper is used to select an image in the image library or using the camera.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 18/08/2019
final public class ImagePickerHelper: NSObject {
    
    /// The delegate.
    public weak var delegate: ImagePickerHelperDelegate?
    
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
        cameraHelper.delegate = self
    }
    
    /// Show the image picker selector.
    public func showImagePicker() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectFromLibraryActionTitle = ImagePickerHelper.selectFromLibraryActionName.localizedInternalString(forType: ImagePickerHelper.self)
        let selectFromLibraryAction = UIAlertAction(title: selectFromLibraryActionTitle, style: .default) { [weak self] _ in
            guard self?.cameraHelper.isLibraryAuthorized == true else {
                self?.cameraHelper.requestLibraryAuthorization()
                return
            }
            self?.showImageViewController(of: .photoLibrary)
        }
        let takePhotoActionTitle = ImagePickerHelper.takePhotoActionName.localizedInternalString(forType: ImagePickerHelper.self)
        let takePhotoAction = UIAlertAction(title: takePhotoActionTitle, style: .default) { [weak self] _ in
            guard self?.cameraHelper.isCameraAuthorized == true else {
                self?.cameraHelper.requestCameraAuthorization()
                return
            }
            self?.showImageViewController(of: .camera)
        }
        let cancelActionTitle = ImagePickerHelper.cancelActionName.localizedInternalString(forType: ImagePickerHelper.self)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { [weak self] _ in
            self?.currentViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(selectFromLibraryAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(cancelAction)
        currentViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// Show the image view controller with a specific type.
    ///
    /// - Parameter type: The type of the image view controller.
    private func showImageViewController(of type: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        currentViewController?.present(imagePickerController, animated: true, completion: nil)
    }
}

/// CameraHelperDelegate
extension ImagePickerHelper: CameraHelperDelegate {
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeCamera result: Bool) {
        if result {
            showImageViewController(of: .camera)
        } else {
            cameraHelper.requestCameraAuthorization()
        }
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeLibrary result: Bool) {
        if result {
            showImageViewController(of: .photoLibrary)
        } else {
            cameraHelper.requestLibraryAuthorization()
        }
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper, didCatchError error: String) {
        delegate?.imagePickerHelper(self, didCatchError: error)
    }
}

/// UIImagePickerControllerDelegate
extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            Logger.standard.logError(ImagePickerHelper.imageError)
            return
        }
        picker.dismiss(animated: true, completion: nil)
        delegate?.imagePickerHelper(self, didPick: image)
    }
}

/// Constants
private extension ImagePickerHelper {
    
    /// The content on the selector.
    static let selectFromLibraryActionName = "SelectFromLibrary"
    static let takePhotoActionName = "TakePhoto"
    static let cancelActionName = "Cancel"
    
    /// System error.
    static let imageError = "There has been error while picking the image."
}
#endif

import AdvancedFoundation
import UIKit
