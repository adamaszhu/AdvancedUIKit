extension LocationViewController: LocationHelperDelegate {
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {
        SystemMessageHelper.standard?.showInfo(allTimeLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {
        SystemMessageHelper.standard?.showInfo(whenInUseLocationAuthorization)
    }
    
    func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
}

import AdvancedUIKit
import UIKit
