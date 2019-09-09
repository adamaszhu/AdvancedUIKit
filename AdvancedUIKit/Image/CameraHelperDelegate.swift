/// CameraHelperDelegate is used when an authorization finished.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
public protocol CameraHelperDelegate: class {
    
    /// The camera has been authorized.
    ///
    /// - Parameter result: Whether the camera has been authorized or not.
    func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeCamera result: Bool)
    
    /// The library has been authorized.
    ///
    /// - Parameter result: Whether the camera has been authorized or not.
    func cameraHelper(_ cameraHelper: CameraHelper, didAuthorizeLibrary result: Bool)
    
    /// An error occurs.
    ///
    /// - Parameter error: The detail of the error.
    func cameraHelper(_ cameraHelper: CameraHelper, didCatchError error: String)
}
