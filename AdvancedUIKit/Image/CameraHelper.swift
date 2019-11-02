#if PHOTO
/// CameraHelper is used to access the information about the camera.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 18/08/2019
final public class CameraHelper {
    
    /// The delegate.
    public weak var delegate: CameraHelperDelegate?
    
    /// The bundle.
    private let bundle: Bundle
    
    /// Whether the camera is enabled by the user or not.
    public var isCameraAuthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        return authorizedStatus == .authorized
    }
    
    /// Whether the camera authorization is still not determinated or not.
    public var isCameraUndetermined: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        return authorizedStatus == .notDetermined
    }
    
    /// Whether the library is enabled by the user or not.
    public var isLibraryAuthorized: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        return authorizedStatus == .authorized
    }
    
    /// Whether the library authorization is still not determinated or not.
    public var isLibraryUndetermined: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        return authorizedStatus == .notDetermined
    }
    
    /// Authorize the camera.
    public func requestCameraAuthorization() {
        guard isCameraUndetermined else {
            delegate?.cameraHelper(self, didCatchError: CameraHelper.cameraAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard isDescriptionKeyExisted(CameraHelper.cameraDescriptionKey) == true else {
            Logger.standard.logError(CameraHelper.descriptionKeyError, withDetail: CameraHelper.cameraDescriptionKey)
            return
        }
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] result in
            guard let self = self else {
                return
            }
            self.delegate?.cameraHelper(self, didAuthorizeCamera: result)
        })
    }
    
    /// Authorize the library.
    public func requestLibraryAuthorization() {
        guard isLibraryUndetermined else {
            delegate?.cameraHelper(self, didCatchError: CameraHelper.libraryAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard isDescriptionKeyExisted(CameraHelper.libraryDescriptionKey) == true else {
            Logger.standard.logError(CameraHelper.descriptionKeyError, withDetail: CameraHelper.libraryDescriptionKey)
            return
        }
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else {
                return
            }
            self.delegate?.cameraHelper(self, didAuthorizeLibrary: result == .authorized)
        }
    }
    
    /// CLLocationManager
    ///
    /// - Parameter bundle: The bundle where the Info.plist file exists.
    public init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    /// Check whether a description key exsits in the Info.plist file or not.
    ///
    /// - Parameter key: The key to be checked.
    /// - Returns: Whether the key exists or not.
    private func isDescriptionKeyExisted(_ key: String) -> Bool {
        return bundle.object(forInfoDictionaryKey: key) != nil
    }
}

/// Constants
private extension CameraHelper {
    
    /// The info key required in the Info.plist file.
    static let cameraDescriptionKey = "NSCameraUsageDescription"
    static let libraryDescriptionKey = "NSPhotoLibraryUsageDescription"
    
    /// User error.
    static let cameraAuthorizationError = "CameraAuthorizationError"
    static let libraryAuthorizationError = "LibraryAuthorizationError"
    
    /// System error.
    static let descriptionKeyError = "The description key doesn't exists in the Info.plist file."
}
#endif

import AdvancedFoundation
import AVFoundation
import Photos
