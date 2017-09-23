/// MapViewDelegate+Optional implements the default action.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 07/06/2017
public extension MapViewDelegate {
    
    func mapView(_ mapView: MapView, didSelectItem item: Any) { }
    func mapView(_ mapView: MapView, didUpdate location: CLLocation) { }
    func mapViewDidMoveView(_ mapView: MapView) { }
    func mapViewWillMoveView(_ mapView: MapView) { }
    
}

import CoreLocation
