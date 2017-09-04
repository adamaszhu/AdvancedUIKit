/// MKCoordinateRegion+Initializer provides initialization based on different criteria.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 08/07/2017
extension MKCoordinateRegion {
    
    /// Initialize the region with center coordinate and zoom level.
    ///
    /// - Parameters:
    ///   - latitude: The center latitude of the view.
    ///   - longitude: The center longitude of the view.
    ///   - zoomLevel: The zoom level.
    init(centerLatitude: Double, centerLongitude: Double, zoomLevel: Double) {
        self.init()
        center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        span = MKCoordinateSpan()
        span.latitudeDelta = 1.0 / zoomLevel
        span.longitudeDelta = 1.0 / zoomLevel
    }
    
    /// Initialize the region with center coordinate and zoom level.
    ///
    /// - Parameters:
    ///   - latitude: The center latitude of the view.
    ///   - longitude: The center longitude of the view.
    ///   - latitudeDelta: The latitude span.
    ///   - longitudeDelta: The longitude span.
    init(centerLatitude: Double, centerLongitude: Double, latitudeDelta: Double, longitudeDelta: Double) {
        self.init()
        center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        span = MKCoordinateSpan()
        span.latitudeDelta = latitudeDelta
        span.longitudeDelta = longitudeDelta
    }
    
}

import MapKit
