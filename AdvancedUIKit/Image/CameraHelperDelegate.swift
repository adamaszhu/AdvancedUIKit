import Foundation

/**
 * CameraHelperDelegate is used when an authorization finished.
 * - author: Adamas
 * - version: 0.0.1
 * - date: 22/10/2016
 */
@objc public protocol CameraHelperDelegate {
    
    /**
     * The camera has been authorized.
     * - version: 0.0.1
     * - date: 22/10/2016
     * - parameter result: Whether the camera has been authorized or not.
     */
    optional func cameraHelper(cameraHelper: CameraHelper, didAuthorizeCamera result: Bool)
    
}
