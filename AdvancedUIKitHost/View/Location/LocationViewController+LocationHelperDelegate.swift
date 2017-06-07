extension LocationViewController: LocationHelperDelegate {
    
    private static let allTimeLocationAuthorization = "All time location authorization is authorized."
    private static let whenInUseLocationAuthorization = "When in use location uthorization is authorized."
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {
        SystemMessageHelper.standard?.showInfo(LocationViewController.allTimeLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {
        SystemMessageHelper.standard?.showInfo(LocationViewController.whenInUseLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
}

import AdvancedUIKit
import UIKit
