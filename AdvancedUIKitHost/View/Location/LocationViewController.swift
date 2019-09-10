final class LocationViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    private lazy var locationHelper: LocationHelper = {
        let locationHelper = LocationHelper()
        locationHelper.locationHelperDelegate = self
        return locationHelper
    }()
    
    @IBAction func registerAlwaysLocation(_ sender: Any) {
        locationHelper.requestAlwaysAuthorization()
    }
    
    @IBAction func registerWhenInUseLocation(_ sender: Any) {
        locationHelper.requestWhenInUseAuthorization()
    }
}

extension LocationViewController: LocationHelperDelegate {
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {
        messageHelper?.showInfo(LocationViewController.allTimeLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {
        messageHelper?.showInfo(LocationViewController.whenInUseLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String) {
        messageHelper?.showInfo(error)
    }
}

private extension LocationViewController {
    static let allTimeLocationAuthorization = "All time location authorization is authorized."
    static let whenInUseLocationAuthorization = "When in use location uthorization is authorized."
}

import AdvancedUIKit
import UIKit
