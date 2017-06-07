/**
 * LocationHelper+LocationManagerDelegate wrap the action of a CLLocationManagerDelegate
 * - author: Adamas
 * - version: 1.0.0
 * - date: 04/05/2017
 */
extension LocationHelper: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch authorizingStatus {
        case .authorizedAlways:
            locationHelperDelegate?.locationHelper(self, didAuthorizeAlwaysAuthorization: LocationHelper.isAlwaysAuthorizationAuthorized)
        case .authorizedWhenInUse:
            locationHelperDelegate?.locationHelper(self, didAuthorizeWhenInUseAuthorization: LocationHelper.isWhenInUseAuthorizationAuthorized)
        default:
            break
        }
        authorizingStatus = .notDetermined
    }
}

import CoreLocation
import Foundation
