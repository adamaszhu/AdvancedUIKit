final class LocationViewController: UIViewController {
    
    let allTimeLocationAuthorization = "All time location authorization is authorized."
    let whenInUseLocationAuthorization = "When in use location uthorization is authorized."
    
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

import AdvancedUIKit
import UIKit
