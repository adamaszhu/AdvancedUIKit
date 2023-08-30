#if !os(macOS) && !targetEnvironment(macCatalyst)
#if PHOTO
/// ImagePickerHelper is used to select an image in the image library or using the camera.
///
/// - author: Adamas
/// - version: 1.6.0
/// - date: 18/08/2019
public final class ImagePickerHelper: NSObject {
    
    /// The delegate.
    public weak var delegate: ImagePickerHelperDelegate?
    
    /// The camera authorization helper.
    private let cameraHelper: CameraHelper
    
    /// The current view controller.
    private let currentViewController: UIViewController?
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application used to make a function call.
    public init(application: UIApplication = .shared,
                cameraHelper: CameraHelper = CameraHelper()) {
        self.cameraHelper = cameraHelper
        currentViewController = application.rootViewController
        super.init()
        cameraHelper.delegate = self
    }
    
    /// Show the image picker selector.
    public func showImagePicker() {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let selectFromLibraryActionTitle = Self.selectFromLibraryActionName.localizedInternalString(forType: Self.self)
        let selectFromLibraryAction = UIAlertAction(title: selectFromLibraryActionTitle,
                                                    style: .default) { [weak self] _ in
            guard self?.cameraHelper.isLibraryAuthorized == true else {
                self?.cameraHelper.requestLibraryAuthorization()
                return
            }
            self?.showImageViewController(of: .photoLibrary)
        }
        let takePhotoActionTitle = Self.takePhotoActionName.localizedInternalString(forType: Self.self)
        let takePhotoAction = UIAlertAction(title: takePhotoActionTitle,
                                            style: .default) { [weak self] _ in
            guard self?.cameraHelper.isCameraAuthorized == true else {
                self?.cameraHelper.requestCameraAuthorization()
                return
            }
            self?.showImageViewController(of: .camera)
        }
        let cancelActionTitle = Self.cancelActionName.localizedInternalString(forType: Self.self)
        let cancelAction = UIAlertAction(title: cancelActionTitle,
                                         style: .default) { [weak self] _ in
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
    private func showImageViewController(of type: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        currentViewController?.present(imagePickerController, animated: true, completion: nil)
    }
}

/// CameraHelperDelegate
extension ImagePickerHelper: CameraHelperDelegate {
    
    public func cameraHelper(_ cameraHelper: CameraHelper,
                             didAuthorizeCamera result: Bool) {
        result
            ? showImageViewController(of: .camera)
            : cameraHelper.requestCameraAuthorization()
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper,
                             didAuthorizeLibrary result: Bool) {
        result
            ? showImageViewController(of: .photoLibrary)
            : cameraHelper.requestLibraryAuthorization()
    }
    
    public func cameraHelper(_ cameraHelper: CameraHelper,
                             didCatchError error: String) {
        delegate?.imagePickerHelper(self, didCatchError: error)
    }
}

/// UIImagePickerControllerDelegate
extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let values = info.map {($0.key.rawValue, $0.value)}
        let info = Dictionary(uniqueKeysWithValues: values)

        guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            Logger.standard.logError(Self.imageError)
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

import AdvancedUIKit
import AdvancedFoundation
import UIKit

#endif
#endif
