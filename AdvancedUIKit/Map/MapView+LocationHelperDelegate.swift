/// MapView+LocationHelperDelegate implements the action related to authorization.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 08/07/2017
extension MapView: LocationHelperDelegate {
    
    public func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String) {
        mapViewDelegate?.mapView(self, didCatchError: error)
    }
    
    public func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {
        showsUserLocation = true
    }
    
    public func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {
        showsUserLocation = true
    }
    
}

import UIKit
