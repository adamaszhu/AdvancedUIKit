/// MapViewDelegate records the action performed on the map.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 07/06/2017
public protocol MapViewDelegate {
    
    /// An error has been caused.
    ///
    /// - Parameter error: The error message.
    func mapView(_ mapView: MapView, didCatchError error: String)
    
    /// A point is selected and detail of the point is required to be presented.
    ///
    /// - Parameter item: The item attached on the point.
    func mapView(_ mapView: MapView, didSelectItem item: Any)
    
    /// The view has been moved.
    func mapViewDidMoveView(_ mapView: MapView)
    
    /// The view has been moved.
    func mapViewWillMoveView(_ mapView: MapView)
    
}
