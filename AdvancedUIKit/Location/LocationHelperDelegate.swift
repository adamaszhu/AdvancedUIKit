/// LocationHelperDelegate is used to perform an action when an action happens.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
public protocol LocationHelperDelegate: class {
    
    /// An error occurs.
    ///
    /// - Parameter error: The detail of the error.
    func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String)
    
    /// Always authorization has been decided.
    ///
    /// - Parameter isAuthorized: Whether the authorization has been granted or not.
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool)
    
    /// When in use authorization has been decided.
    ///
    /// - Parameter isAuthorized: Whether the authorization has been granted or not.
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool)
}

/// Constants
public extension LocationHelperDelegate {
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {}
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {}
}

import Foundation
