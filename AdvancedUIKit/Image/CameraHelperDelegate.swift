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
    
    /**
     * The library has been authorized.
     * - parameter result: Whether the camera has been authorized or not.
     */
    func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeLibrary result: Bool)
    
    /**
     * An error occurs.
     * - parameter error: The detail of the error.
     */
    func cameraHelper(_ cameraHelper: CameraHelper, didCatchError error: String)
    
}
