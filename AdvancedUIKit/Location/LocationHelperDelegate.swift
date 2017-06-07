/**
 * LocationHelperDelegate is used to perform an action when an action happens.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 04/05/2017
 */
public protocol LocationHelperDelegate {
    
    /**
     * Always authorization has been decided.
     * - parameter isAuthorized: Whether the authorization has been granted or not.
     */
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool)
    
    /**
     * When in use authorization has been decided.
     * - parameter isAuthorized: Whether the authorization has been granted or not.
     */
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool)
    
}

import Foundation

