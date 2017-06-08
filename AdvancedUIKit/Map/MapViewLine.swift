/**
 * MapViewLine record the information of a line on the map.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public struct MapViewLine {
    
    /**
     * The width of the line.
     */
    private static let defaultLineColor = UIColor.black
    
    /**
     * The width of the line.
     */
    private static let defaultLineWidth = 2
    
    /**
     * The line object.
     */
    let line: MKPolyline
    
    /**
     * The color of the line.
     */
    let color: UIColor
    
    /**
     * The width of the line.
     */
    let width: Int
    
    /**
     * All points on the line.
     */
    let points: Array<MapViewPoint>
    
    /**
     * The renderer.
     */
    var renderer: MKPolylineRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: line)
        polylineRenderer.strokeColor = color
        polylineRenderer.lineWidth = CGFloat(width)
        return polylineRenderer
    }
    
    /**
     * Initialize the object.
     * - parameter points: A list of point list.
     * - parameter color: The color of the line.
     * - parameter width: The width of the line.
     */
    init(points: Array<MapViewPoint>, color: UIColor = defaultLineColor, width: Int = defaultLineWidth) {
        let coordinates = points.map { point in
            point.annotation.coordinate
        }
        line = MKPolyline(coordinates: coordinates, count: coordinates.count)
        self.width = width
        self.color = color
        self.points = points
    }
    
}

import MapKit
import UIKit
