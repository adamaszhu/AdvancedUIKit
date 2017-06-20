/**
 * Coordinate+Measurer provides measure between two geo location.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 15/06/2017
 */
public extension CLLocationCoordinate2D {
    
    /**
     * Calculate the distance between two geo coordinate.
     * - parameter coordinate: The second coordinate.
     * - returns: The distance in meter.
     */
    public func distanceTo(_ coordinate: CLLocationCoordinate2D) -> Double {
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        let remoteLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return currentLocation.distance(from: remoteLocation)
    }
    
}

import MapKit
