/// Coordinate+Measurer provides measure between two geo location.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
public extension CLLocationCoordinate2D {
    
    /// Calculate the distance between two geo coordinate.
    ///
    /// - Parameter coordinate: The second coordinate.
    /// - Returns: The distance in meter.
    func distance(to coordinate: CLLocationCoordinate2D) -> Double {
        let currentLocation = CLLocation(latitude: latitude,
                                         longitude: longitude)
        let remoteLocation = CLLocation(latitude: coordinate.latitude,
                                        longitude: coordinate.longitude)
        return currentLocation.distance(from: remoteLocation)
    }
}

import MapKit
