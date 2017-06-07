/**
 * MapView+Delegate perform an required action on the map view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
extension MapView: MKMapViewDelegate {
    
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
    //
    //    /**
    //     * MKMapViewDelegate
    //     */
    //    public func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    //        for point in pointList {
    //            if point.view === view {
    //                selectedPoint = point
    //                return
    //            }
    //        }
    //    }
    //
    //    /**
    //     * MKMapViewDelegate
    //     */
    //    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    //        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(MapView.MapViewPointID)
    //        if annotationView == nil {
    //            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapView.MapViewPointID)
    //        }
    //        var mapViewPoint: MapViewPoint?
    //        // COMMENT: Try to find the point in the point list.
    //        for point in pointList {
    //            if point.annotation === annotation {
    //                mapViewPoint = point
    //                break
    //            }
    //        }
    //        // COMMENT: Try to find the point in the line list.
    //        for line in lineList {
    //            for point in line.pointList {
    //                if point.annotation === annotation {
    //                    mapViewPoint = point
    //                    break
    //                }
    //            }
    //        }
    //        mapViewPoint?.renderView(annotationView!)
    //        return annotationView
    //    }
    //
    //    /**
    //     * MKMapViewDelegate
    //     */
    //    public func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    //        // COMMENT: Try to find the point in the line list.
    //        var mapViewLine: MapViewLine?
    //        for line in lineList {
    //            if line.line === overlay {
    //                mapViewLine = line
    //                break
    //            }
    //        }
    //        if mapViewLine == nil {
    //            return MKOverlayRenderer()
    //        }
    //        return mapViewLine!.renderer
    //    }
}

import MapKit
import UIKit
