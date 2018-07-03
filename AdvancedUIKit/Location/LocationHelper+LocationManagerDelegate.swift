/// LocationHelper+LocationManagerDelegate wrap the action of a CLLocationManagerDelegate
///
/// - author: Adamas
/// - version: 1.3.0
/// - date: 02/07/2018
extension LocationHelper: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != .notDetermined else {
            return
        }
        switch authorizingStatus {
        case .authorizedAlways:
            locationHelperDelegate?.locationHelper(self, didAuthorizeAlwaysAuthorization: isAlwaysAuthorizationAuthorized)
        case .authorizedWhenInUse:
            locationHelperDelegate?.locationHelper(self, didAuthorizeWhenInUseAuthorization: isWhenInUseAuthorizationAuthorized)
        default:
            break
        }
        authorizingStatus = .notDetermined
    }
    
}

import CoreLocation
import Foundation
