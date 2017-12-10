/// LocationHelper+Constant defines all constants used by LocationHelper.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 14/09/2017
extension LocationHelper {
    
    /// The info key required in the Info.plist file.
    @objc static let alwaysDescriptionKey = "NSLocationAlwaysUsageDescription"
    @objc static let whenInUseDescriptionKey = "NSLocationWhenInUseUsageDescription"
    
    /// User error.
    @objc static let authorizationError = "AuthorizationError"
    
    /// System error.
    @objc static let descriptionKeyError = "The description key doesn't exists in the Info.plist file."
    
}

import Foundation
