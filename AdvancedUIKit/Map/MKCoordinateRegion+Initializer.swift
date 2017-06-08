/**
 * MKCoordinateRegion+Initializer provides initialization based on different criteria.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 08/07/2017
 */
extension MKCoordinateRegion {
    
    /**
     * Initialize the region with center coordinate and zoom level.
     * - parameter latitude: The center latitude of the view.
     * - parameter longitude: The center longitude of the view.
     * - parameter zoomLevel: The zoom level.
     */
    init(centerLatitude: Double, centerLongitude: Double, zoomLevel: Double) {
        self.init()
        center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        span = MKCoordinateSpan()
        span.latitudeDelta = 1.0 / zoomLevel
        span.longitudeDelta = 1.0 / zoomLevel
    }
    
}

import MapKit
