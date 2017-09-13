/// CameraHelper+Constant defines all constants used by CameraHelper.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension CameraHelper {
    
    /// The info key required in the Info.plist file.
    static let cameraDescriptionKey = "NSCameraUsageDescription"
    static let libraryDescriptionKey = "NSPhotoLibraryUsageDescription"
    
    /// User error.
    static let cameraAuthorizationError = "CameraAuthorizationError"
    static let libraryAuthorizationError = "LibraryAuthorizationError"
    
    /// System error.
    static let descriptionKeyError = "The description key doesn't exists in the Info.plist file."
    
}
