/**
 * LocationHelper provides additional support for LocationManager.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 04/05/2017
 */
public class LocationHelper: CLLocationManager {
    
    /**
     * The delegate.
     */
    public var locationHelperDelegate: LocationHelperDelegate?
    
    /**
     * Which authorization is
     */
    public static var isAlwaysAuthorizationAuthorized: Bool {
        switch authorizationStatus() {
        case .authorizedAlways:
            return true
        default:
            return false
        }
    }
    
    /**
     * Whether the when in use authorization is authorized or not.
     */
    public static var isWhenInUseAuthorizationAuthorized: Bool {
        switch authorizationStatus() {
        case .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    /**
     * The type of authorization that has been requested.
     */
    var authorizingStatus: CLAuthorizationStatus
    
    /**
     * CLLocationManager.
     */
    public override init() {
        authorizingStatus = .notDetermined
        super.init()
    }
    
    /**
     * CLLocationManager.
     */
    public override func requestAlwaysAuthorization() {
        authorizingStatus = .authorizedAlways
        super.requestAlwaysAuthorization()
    }
    
    /**
     * CLLocationManager.
     */
    public override func requestWhenInUseAuthorization() {
        authorizingStatus = .authorizedWhenInUse
        super.requestWhenInUseAuthorization()
    }
    
}

import CoreLocation
import Foundation
