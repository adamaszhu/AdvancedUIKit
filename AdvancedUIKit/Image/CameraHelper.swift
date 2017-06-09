import Foundation
import AVFoundation

/**
 * CameraHelper is used to access the information about the camera.
 * - author: Adamas
 * - date: 22/10/2016
 * - version: 0.0.1
 */
public class CameraHelper: NSObject {
    
    
    /**
     * Whether the camera is enabled by the user or not.
     */
    public static var isCameraAuthorized: Bool {
        /**
         * - date: 22/10/2016
         * - version: 0.0.1
         */
        get {
            let authorizedStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
            switch authorizedStatus {
            case .Authorized:
                return true
            default:
                return false
            }
        }
    }
    
    /**
     * The delegate.
     */
    public var cameraHelperDelegate: CameraHelperDelegate?
    
    /**
     * Authorize the camera.
     * - date: 22/10/2016
     * - version: 0.0.1
     */
    public func authorizeCamera() {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (result: Bool) in
            self.cameraHelperDelegate?.cameraHelper?(self, didAuthorizeCamera: result)
        })
    }
}
