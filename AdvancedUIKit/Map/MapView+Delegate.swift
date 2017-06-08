/**
 * MapView+Delegate perform an required action on the map view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
extension MapView: MKMapViewDelegate {
    
    /**
     * System error.
     */
    private static let pointError = "The point doesn't exist."
    private static let lineError = "The line doesn't exist."
    
    /**
     * Find the line containing the overlay.
     * - parameter overlay: The overlay.
     * - returns: The line. Nil if it is not found.
     */
    private func findLine(with overlay: MKOverlay) -> MapViewLine? {
        for line in lines {
            if line.line === overlay {
                return line
            }
        }
        return nil
    }
    
    /**
     * Find the point containing the annotation in a list of points.
     * - parameter annotation: The annotation.
     * - parameter list: The point list.
     * - returns: The point. Nil if it is not found.
     */
    private func findPoint(with annotation: MKAnnotation, in list: Array<MapViewPoint>) -> MapViewPoint? {
        for point in list {
            if point.annotation === annotation {
                return point
            }
        }
        return nil
    }
    
    /**
     * Find the point containing the annotation in a line.
     * - parameter annotation: The annotation.
     * - returns: The point. Nil if it is not found.
     */
    private func findLinePoint(with annotation: MKAnnotation) -> MapViewPoint? {
        for line in lines {
            if let point = findPoint(with: annotation, in: line.points) {
                return point
            }
        }
        return nil
    }
    
    /**
     * MKMapViewDelegate
     */
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewDidMoveView(self)
    }
    
    /**
     * MKMapViewDelegate
     */
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewWillMoveView(self)
    }
    
    /**
     * MKMapViewDelegate
     */
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusableID = String(describing: MapViewPoint.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: reusableID) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reusableID)
        var point: MapViewPoint
        if let singlePoint = findPoint(with: annotation, in: points) {
            point = singlePoint
        } else if let linePoint = findLinePoint(with: annotation) {
            point = linePoint
        } else {
            Logger.standard.logError(MapView.pointError)
            return nil
        }
        view.render(point)
        return view
    }
    
    /**
     * MKMapViewDelegate
     */
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let line = findLine(with: overlay) else {
            Logger.standard.logError(MapView.lineError)
            return MKOverlayRenderer()
        }
        return line.renderer
    }
    
}

import MapKit
import UIKit
