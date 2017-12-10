/// CameraHelper is used to access the information about the camera.
///
/// - author: Adamas
/// - version: 1.0.4
/// - date: 08/12/2017
final public class CameraHelper {
    
    /// The delegate.
    public var cameraHelperDelegate: CameraHelperDelegate?
    
    /// The bundle.
    private let bundle: Bundle
    
    /// Whether the camera is enabled by the user or not.
    public var isCameraAuthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizedStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// Whether the camera authorization is still not determinated or not.
    public var isCameraUnauthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizedStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }
    
    /// Whether the library is enabled by the user or not.
    public var isLibraryAuthorized: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizedStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// Whether the library authorization is still not determinated or not.
    public var isLibraryUnauthorized: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizedStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }
    
    /// Authorize the camera.
    public func requestCameraAuthorization() {
        guard isCameraUnauthorized else {
            cameraHelperDelegate?.cameraHelper(self, didCatchError: CameraHelper.cameraAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard isDescriptionKeyExisted(CameraHelper.cameraDescriptionKey) == true else {
            Logger.standard.log(error: CameraHelper.descriptionKeyError, withDetail: CameraHelper.cameraDescriptionKey)
            return
        }
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] (result) in
            self.cameraHelperDelegate?.cameraHelper(self, didAuthorizeCamera: result)
        })
    }
    
    /// Authorize the library.
    public func requestLibraryAuthorization() {
        guard isLibraryUnauthorized else {
            cameraHelperDelegate?.cameraHelper(self, didCatchError: CameraHelper.libraryAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard isDescriptionKeyExisted(CameraHelper.libraryDescriptionKey) == true else {
            Logger.standard.log(error: CameraHelper.descriptionKeyError, withDetail: CameraHelper.libraryDescriptionKey)
            return
        }
        PHPhotoLibrary.requestAuthorization { [unowned self] (result) in
            self.cameraHelperDelegate?.cameraHelper(self, didAuthorizeLibrary: result == .authorized)
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

import AVFoundation
import Foundation
import Photos
