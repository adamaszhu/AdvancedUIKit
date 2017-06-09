/**
 * CameraHelperDelegate is used when an authorization finished.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 10/06/2017
 */
public protocol CameraHelperDelegate {
    
    /**
     * The camera has been authorized.
     * - parameter result: Whether the camera has been authorized or not.
     */
    func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeCamera result: Bool)
    
}
