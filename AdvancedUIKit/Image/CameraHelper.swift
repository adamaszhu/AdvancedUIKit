/// CameraHelper is used to access the information about the camera.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 10/06/2017
public class CameraHelper {
    
    /// The info key required in the Info.plist file.
    private static let cameraDescriptionKey = "NSCameraUsageDescription"
    private static let libraryDescriptionKey = "NSPhotoLibraryUsageDescription"
    
    /// User error.
    private static let cameraAuthorizationError = "CameraAuthorizationError"
    private static let libraryAuthorizationError = "LibraryAuthorizationError"
    
    /// System error.
    private static let descriptionKeyError = "The description key doesn't exists in the Info.plist file."
    
    /// Whether the camera is enabled by the user or not.
    public static var isCameraAuthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authorizedStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// Whether the camera authorization is still not determinated or not.
    public static var isCameraUnauthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authorizedStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }
    
    /// Whether the library is enabled by the user or not.
    public static var isLibraryAuthorized: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizedStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// Whether the library authorization is still not determinated or not.
    public static var isLibraryUnauthorized: Bool {
        let authorizedStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizedStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }
    
    /// The delegate.
    public var cameraHelperDelegate: CameraHelperDelegate?
    
    /// The bundle.
    private let bundle: Bundle
    
    /// Authorize the camera.
    public func requestCameraAuthorization() {
        guard CameraHelper.isCameraUnauthorized else {
            cameraHelperDelegate?.cameraHelper(self, didCatchError: CameraHelper.cameraAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard checkDescriptionKey(CameraHelper.cameraDescriptionKey) == true else {
            Logger.standard.log(error: CameraHelper.descriptionKeyError, withDetail: CameraHelper.cameraDescriptionKey)
            return
        }
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [unowned self] (result) in
            self.cameraHelperDelegate?.cameraHelper(self, didAuthorizeCamera: result)
        })
    }
    
    /// Authorize the library.
    public func requestLibraryAuthorization() {
        guard CameraHelper.isLibraryUnauthorized else {
            cameraHelperDelegate?.cameraHelper(self, didCatchError: CameraHelper.libraryAuthorizationError.localizedInternalString(forType: CameraHelper.self))
            return
        }
        guard checkDescriptionKey(CameraHelper.libraryDescriptionKey) == true else {
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
    private func checkDescriptionKey(_ key: String) -> Bool {
        return bundle.object(forInfoDictionaryKey: key) != nil
    }
    
}

import AVFoundation
import Foundation
import Photos
