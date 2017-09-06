/// MapViewLine record the information of a line on the map.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 07/06/2017
public struct MapViewLine {
    
    /// The width of the line.
    private static let defaultLineColor = UIColor.black
    
    /// The width of the line.
    private static let defaultLineWidth = 2
    
    /// The line object.
    let line: MKPolyline
    
    /// The color of the line.
    let color: UIColor
    
    /// The width of the line.
    let width: Int
    
    /// All points on the line.
    let points: [MapViewPoint]
    
    /// The icon for each point on the view.
    let pointIcon: UIImage?
    
    /// The renderer.
    var renderer: MKPolylineRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: line)
        polylineRenderer.strokeColor = color
        polylineRenderer.lineWidth = CGFloat(width)
        return polylineRenderer
    }
    
    /// Initialize the object.
    ///
    /// - Parameters:
    ///   - points: A list of point list.
    ///   - color: The color of the line.
    ///   - width: The width of the line.
    ///   - pointIcon: The icon for the points on the line. Nil if the point should be shown.
    public init(points: [MapViewPoint], color: UIColor = defaultLineColor, width: Int = defaultLineWidth, withPointIcon pointIcon: UIImage? = nil) {
        let coordinates = points.map { point in
            point.annotation.coordinate
        }
        line = MKPolyline(coordinates: coordinates, count: coordinates.count)
        self.width = width
        self.color = color
        self.pointIcon = pointIcon
        if let icon = pointIcon {
            for point in points {
                point.icon = icon
            }
        }
        self.points = points
    }
    
}

import MapKit
import UIKit
