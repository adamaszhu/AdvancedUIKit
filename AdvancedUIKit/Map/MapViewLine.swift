#if !os(macOS)
/// MapViewLine record the information of a line on the map.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/09/2019
public struct MapViewLine {
    
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
    public init(points: [MapViewPoint],
                color: UIColor = defaultLineColor,
                width: Int = defaultLineWidth,
                pointIcon: UIImage? = nil) {
        let coordinates = points.map { $0.annotation.coordinate }
        line = MKPolyline(coordinates: coordinates,
                          count: coordinates.count)
        self.width = width
        self.color = color
        self.pointIcon = pointIcon
        if let icon = pointIcon {
            points.forEach {
                $0.icon = icon
            }
        }
        self.points = points
    }
}

/// Equatable
extension MapViewLine: Equatable {
    
    public static func == (lhs: MapViewLine, rhs: MapViewLine) -> Bool {
        lhs.points == rhs.points
    }
}

/// Constants
public extension MapViewLine {
    
    /// The width of the line.
    static let defaultLineColor = UIColor.black
    
    /// The width of the line.
    static let defaultLineWidth = 2
}

import MapKit
import UIKit
#endif
