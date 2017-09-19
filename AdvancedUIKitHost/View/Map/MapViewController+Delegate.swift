extension MapViewController: MapViewDelegate {
    
    func mapView(_ mapView: MapView, didCatchError error: String) {
        SystemMessageHelper.standard?.showInfo(error)
    }
    
    func mapView(_ mapView: MapView, didSelectItem item: Any) {
        if let name = item as? String {
            SystemMessageHelper.standard?.showInfo(name)
        }
    }
    
    func mapView(_ mapView: MapView, didUpdate location: CLLocation) {
        updateDistance(to: location.coordinate)
    }
    
    func mapViewDidMoveView(_ mapView: MapView) {
        guard mapView.userLocation.coordinate.latitude != 0, mapView.userLocation.coordinate.longitude != 0 else {
            return
        }
        updateDistance(to: mapView.userLocation.coordinate)
    }
    
    private func updateDistance(to coordinate: CLLocationCoordinate2D) {
        let distance = coordinate.distance(to: mapView.centerCoordinate) / 1000
        distanceLabel.text = String(format: distancePattern, distance)
    }
    
}

import AdvancedUIKit
import CoreLocation
import UIKit
