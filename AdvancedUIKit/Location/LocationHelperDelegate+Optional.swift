/**
 * LocationHelperDelegate+Optional defines some optional function in the delegate.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public extension LocationHelperDelegate {
    
    /**
     * LocationHelperDelegate
     */
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) { }
    
    /**
     * LocationHelperDelegate
     */
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) { }
    
}

