#if PHOTO
/// CameraError defines all error related to the camera permission.
///
/// - author: Adamas
/// - version: 1.9.16
/// - date: 30/05/2023
public enum CameraError: Error {
    
    // If the permission has already been decided
    case authorization
    
    // If there is no description key in the plist file
    case description
}
#endif
