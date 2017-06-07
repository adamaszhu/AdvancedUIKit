import MapKit

/**
 * MapViewLine record the information of a line on the map.
 * - author: Adamas
 * - version: 0.0.1
 * - date: 27/10/2016
 */
class MapViewLine: AnyObject {
    
    /**
     * The renderer.
     */
    var renderer: MKPolylineRenderer {
        /**
         * - version: 0.0.3
         * - date: 27/10/2016
         */
        get {
            var polylineRenderer = MKPolylineRenderer(overlay: line)
            polylineRenderer.strokeColor = color
            polylineRenderer.lineWidth = CGFloat(lineWidth)
            return polylineRenderer
        }
    }
    
    /**
     * The line object.
     */
    private (set) var line: MKPolyline
    
    /**
     * The point.
     */
    private (set) var pointList: Array<MapViewPoint>
    
    /**
     * The color of the line.
     */
    private var color: UIColor
    
    /**
     * The width of the line.
     */
    private var lineWidth: Int
    
    /**
     * Initialize the object.
     * - version: 0.0.2
     * - date: 12/10/2016
     * - parameter pointList: A list of point list.
     * - parameter color: The color of the line.
     * - parameter width: The width of the line.
     * - parameter icon: The icon of the point on the line.
     */
    init(withPointList pointList: Array<MapViewPoint>, withColor color: UIColor, withLineWidth width: Int) {
        var coordinateList = [CLLocationCoordinate2D]()
        for point in pointList {
            coordinateList.append(point.annotation.coordinate)
        }
        line = MKPolyline(coordinates: coordinateList, count: coordinateList.count)
        lineWidth = width
        self.color = color
        self.pointList = pointList
    }
    
}
