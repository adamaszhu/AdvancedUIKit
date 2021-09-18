#if !os(macOS)
/// MapViewDelegate records the action performed on the map.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/09/2019
public protocol MapViewDelegate: AnyObject {
    
    /// An error has been caused.
    ///
    /// - Parameter error: The error message.
    func mapView(_ mapView: MapView, didCatchError error: String)
    
    /// A point is selected and detail of the point is required to be presented.
    ///
    /// - Parameter item: The item attached on the point.
    func mapView(_ mapView: MapView, didSelectItem item: Any)
    
    
    /// A new user location has been detected
    ///
    /// - Parameter location: Updated user location
    func mapView(_ mapView: MapView, didUpdate location: CLLocation)
    
    /// The view has been moved.
    func mapViewDidMoveView(_ mapView: MapView)
    
    /// The view has been moved.
    func mapViewWillMoveView(_ mapView: MapView)
}

/// Optional
public extension MapViewDelegate {
    func mapView(_ mapView: MapView, didSelectItem item: Any) {}
    func mapView(_ mapView: MapView, didUpdate location: CLLocation) {}
    func mapViewDidMoveView(_ mapView: MapView) {}
    func mapViewWillMoveView(_ mapView: MapView) {}
}

import CoreLocation
#endif
