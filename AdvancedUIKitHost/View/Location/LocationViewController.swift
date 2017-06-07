class LocationViewController: UIViewController {
    
    private let locationHelper: LocationHelper
    
    required init?(coder aDecoder: NSCoder) {
        locationHelper = LocationHelper()
        super.init(coder: aDecoder)
        locationHelper.locationHelperDelegate = self
    }
    
    @IBAction func registerAlwaysLocation(_ sender: Any) {
        locationHelper.requestAlwaysAuthorization()
    }
    
    @IBAction func registerWhenInUseLocation(_ sender: Any) {
        locationHelper.requestWhenInUseAuthorization()
    }
    
}

import AdvancedUIKit
import UIKit
