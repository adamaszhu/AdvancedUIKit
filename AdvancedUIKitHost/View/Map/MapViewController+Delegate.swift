extension MapViewController: MapViewDelegate {
    
    func mapView(_ mapView: MapView, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
    func mapView(_ mapView: MapView, didSelectItem item: Any) {
        if let name = item as? String {
            SystemMessageHelper.standard?.showInfo(name)
        }
    }
    
}

import AdvancedUIKit
import UIKit
