/// LocationHelper provides additional support for LocationManager.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/09/2019
open class LocationHelper: CLLocationManager {
    
    /// The delegate.
    public weak var locationHelperDelegate: LocationHelperDelegate?
    
    /// The type of authorization that has been requested.
    private var authorizingStatus: CLAuthorizationStatus = .notDetermined
    
    /// The bundle.
    private let bundle: Bundle
    
    /// Which authorization is
    open var isAlwaysAuthorizationAuthorized: Bool {
        CLLocationManager.authorizationStatus() == .authorizedAlways
    }
    
    /// Whether the when in use authorization is authorized or not.
    open var isWhenInUseAuthorizationAuthorized: Bool {
        CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    /// Whether the authorization is still not determinated or not.
    open var isUnauthorized: Bool {
        CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    /// CLLocationManager
    ///
    /// - Parameter bundle: The bundle where the Info.plist file exists.
    public init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
        super.init()
        delegate = self
    }
    
    /// Check whether a description key exsits in the Info.plist file or not.
    ///
    /// - Parameter key: The key to be checked.
    /// - Returns: Whether the key exists or not.
    private func checkDescriptionKey(_ key: String) -> Bool {
        bundle.object(forInfoDictionaryKey: key) != nil
    }
    
    open override func requestAlwaysAuthorization() {
        guard isUnauthorized else {
            locationHelperDelegate?.locationHelper(self, didCatchError: Self.authorizationError.localizedInternalString(forType: Self.self))
            return
        }
        guard checkDescriptionKey(Self.alwaysDescriptionKey) else {
            Logger.standard.logError(Self.descriptionKeyError, withDetail: Self.alwaysDescriptionKey)
            return
        }
        authorizingStatus = .authorizedAlways
        super.requestAlwaysAuthorization()
    }
    
    open override func requestWhenInUseAuthorization() {
        guard isUnauthorized else {
            locationHelperDelegate?.locationHelper(self, didCatchError: Self.authorizationError.localizedInternalString(forType: Self.self))
            return
        }
        guard checkDescriptionKey(Self.whenInUseDescriptionKey) else {
            Logger.standard.logError(Self.descriptionKeyError, withDetail: Self.whenInUseDescriptionKey)
            return
        }
        authorizingStatus = .authorizedWhenInUse
        super.requestWhenInUseAuthorization()
    }
}

/// CLLocationManagerDelegate
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

/// Constants
private extension LocationHelper {
    
    /// The info key required in the Info.plist file.
    static let alwaysDescriptionKey = "NSLocationAlwaysAndWhenInUseUsageDescription"
    static let whenInUseDescriptionKey = "NSLocationWhenInUseUsageDescription"
    
    /// User error.
    static let authorizationError = "AuthorizationError"
    
    /// System error.
    static let descriptionKeyError = "The description key doesn't exists in the Info.plist file."
}

import AdvancedFoundation
import CoreLocation
import Foundation
