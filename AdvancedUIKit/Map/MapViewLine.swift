/**
 * MapViewLine record the information of a line on the map.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public struct MapViewLine {
    
    /**
     * The line object.
     */
    private let line: MKPolyline
    
    /**
     * The color of the line.
     */
    private let color: UIColor
    
    /**
     * The width of the line.
     */
    private let width: Int
    
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
    init(points: Array<MapViewPoint>, color: UIColor, width: Int) {
        let coordinates = points.map { point in
            point.annotation.coordinate
        }
        line = MKPolyline(coordinates: coordinates, count: coordinates.count)
        self.width = width
        self.color = color
    }
    
}

import MapKit
import UIKit
