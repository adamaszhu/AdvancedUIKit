/**
 * CameraHelper is used to access the information about the camera.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public class CameraHelper {
    
    
    /**
     * Whether the camera is enabled by the user or not.
     */
    public static var isCameraAuthorized: Bool {
        let authorizedStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authorizedStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /**
     * The delegate.
     */
    public var cameraHelperDelegate: CameraHelperDelegate?
    
    /**
     * Authorize the camera.
     */
    public func authorizeCamera() {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [unowned self] (result) in
            self.cameraHelperDelegate?.cameraHelper(self, didAuthorizeCamera: result)
        })
    }
}

import Foundation
import AVFoundation
