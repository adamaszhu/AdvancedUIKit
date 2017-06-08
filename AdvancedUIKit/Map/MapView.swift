/**
 * A customized MapView with additional actions.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public class MapView: MKMapView {
    
    /**
     * The size of a pin icon.
     */
    private static let defaultIconSize = Double(40)
    
    /**
     * The size of a pin icon on the line.
     */
    private static let defaultLineIconSize = Double(20)
    
    /**
     * The default size of the viewport.
     */
    private static let defaultViewportMargin = Double(1)
    
    /**
     * The delegate of the map.
     */
    public var mapViewDelegate: MapViewDelegate?
    
    /**
     * The point list.
     */
    var points: Array<MapViewPoint>
    
    /**
     * The line list.
     */
    var lines: Array<MapViewLine>
    
    /**
     * Set the view of the map.
     * - parameter latitude: The center latitude of the view.
     * - parameter longitude: The center longitude of the view.
     * - parameter zoomLevel: The zoom level. If it is nil, zoom level will not be changed.
     * - parameter shouldAnimate: Whether the animation should be allowed or not.
     */
    public func setViewport(withCenterLatitude latitude: Double, withCenterLongitude longitude: Double, withZoomLevel zoomLevel: Double? = nil, withAnimation shouldAnimate: Bool = true) {
        var region: MKCoordinateRegion
        if let zoomLevel = zoomLevel {
            region = MKCoordinateRegion(centerLatitude: latitude, centerLongitude: longitude, zoomLevel: zoomLevel)
        } else {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            region = MKCoordinateRegion(center: coordinate, span: self.region.span)
        }
        setRegion(region, animated: shouldAnimate)
    }
    //
    //    /**
    //     * Adjust the viewport according to the points within it.
    //     * - version: 0.0.3
    //     * - date: 27/10/2016
    //     */
    //    public func adjustViewport() {
    //        var maxLatitude = Double(-90)
    //        var minLatitude = Double(90)
    //        var maxLongitude = Double(-180)
    //        var minLongitude = Double(180)
    //        switch annotations.count {
    //        case 0:
    //            maxLatitude = 90
    //            minLatitude = -90
    //            maxLongitude = 180
    //            minLongitude = -180
    //        default:
    //            var pointLatitude = Double(0)
    //            var pointLongitude = Double(0)
    //            for index in 0 ..< annotations.count {
    //                pointLatitude = annotations[index].coordinate.latitude
    //                pointLongitude = annotations[index].coordinate.longitude
    //                minLatitude = pointLatitude < minLatitude ? pointLatitude : minLatitude
    //                maxLatitude = pointLatitude > maxLatitude ? pointLatitude : maxLatitude
    //                minLongitude = pointLongitude < minLongitude ? pointLongitude : minLongitude
    //                maxLongitude = pointLongitude > maxLongitude ? pointLongitude : maxLongitude
    //            }
    //        }
    //        maxLatitude = maxLatitude + MapView.DefaultViewportMargin / 2
    //        maxLatitude = maxLatitude > 90 ? 90 : maxLatitude
    //        minLatitude = minLatitude - MapView.DefaultViewportMargin / 2
    //        minLatitude = minLatitude < -90 ? -90 : minLatitude
    //        maxLongitude = maxLongitude + MapView.DefaultViewportMargin / 2
    //        maxLongitude = maxLongitude > 180 ? 180 : maxLongitude
    //        minLongitude = minLongitude - MapView.DefaultViewportMargin / 2
    //        minLongitude = minLongitude < -180 ? -180 : minLongitude
    //        setViewport(withTopLatitude: maxLatitude, withBottomLatitude: minLatitude, withLeftLongitude: minLongitude, withRightLongitude: maxLongitude)
    //    }
    //
    //
    //    /**
    //     * Set the view of the map.
    //     * - version: 0.0.2
    //     * - date: 12/10/2016
    //     * - parameter topLatitude: The top latitude.
    //     * - parameter bottomLatitude: The bottom latitude.
    //     * - parameter leftLongitude: The left longitude.
    //     * - parameter rightLongitude: The right longitude.
    //     * - parameter shouldAnimate: Whether the animation should be performed or not.
    //     */
    //    public func setViewport(withTopLatitude topLatitude: Double, withBottomLatitude bottomLatitude: Double, withLeftLongitude leftLongitude: Double, withRightLongitude rightLongitude: Double, withAnimation shouldAnimate: Bool = true) {
    //        // TODO: Consider about special map situation.
    //        var centerLatitude = (topLatitude + bottomLatitude) / 2
    //        centerLatitude = centerLatitude == 0 ? 0.001 : centerLatitude
    //        var centerLongitude = (leftLongitude + rightLongitude) / 2
    //        centerLongitude = centerLongitude == 0 ? 0.001 : centerLongitude
    //        var region = MKCoordinateRegion()
    //        region.center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
    //        var span = MKCoordinateSpan()
    //        span.latitudeDelta = topLatitude - bottomLatitude
    //        span.longitudeDelta = rightLongitude - leftLongitude
    //        let pointIconWidth = pointIcon == nil ? 0 : pointIcon!.size.width
    //        let pointIconHeight = pointIcon == nil ? 0 : pointIcon!.size.height
    //        // COMMENT: Change ratio according to the ratio of the view.
    //        let ratio = (frame.size.height - pointIconHeight) / (frame.size.width - pointIconWidth)
    //        if ((span.latitudeDelta / span.longitudeDelta) > Double(ratio)) {
    //            span.longitudeDelta = span.latitudeDelta / Double(ratio);
    //        } else {
    //            span.latitudeDelta = Double(ratio) * span.longitudeDelta;
    //        }
    //        // COMMENT: Give the margin space to the icon.
    //        // COMMENT: self.frame.size.height / (self.frame.size.height - _pointIcon.size.height) > self.frame.size.width / (self.frame.size.width - _pointIcon.size.width)
    //        let frameRadio = ratio * pointIconWidth / pointIconHeight < 1 ?  frame.size.height / (frame.size.height - pointIconHeight) : frame.size.width / (frame.size.width - pointIconWidth)
    //        span.latitudeDelta *= Double(frameRadio);
    //        span.longitudeDelta *= Double(frameRadio);
    //        span.latitudeDelta = span.latitudeDelta > 90 ? 90 : span.latitudeDelta;
    //        span.longitudeDelta = span.longitudeDelta > 360 ? 360 : span.longitudeDelta;
    //        region.span = span;
    //        // COMMENT: Set offset according to the icon.
    //        let fixedLatitude = Double(region.center.latitude) + region.span.latitudeDelta * Double(pointIconHeight) / 2 / Double(frame.size.height)
    //        region.center = CLLocationCoordinate2D(latitude: fixedLatitude, longitude: region.center.longitude)
    //        self.setRegion(region, animated: shouldAnimate)
    //    }
    //
    //    /**
    //     * Add a point on the map.
    //     * - version: 0.0.3
    //     * - date: 27/10/2016
    //     * - parameter latitude: The latitude of the point.
    //     * - parameter longitude: The longitude of the point.
    //     * - parameter title: The title of the point.
    //     * - parameter subtitle: The subtitle of the point.
    //     * - parameter item: The item attached to the point.
    //     * - parameter icon: The icon of the point.
    //     */
    //    public func addPoint(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String, withSubtitle subtitle: String, withItem item: AnyObject? = nil, withIcon icon: UIImage? = nil) { withIconSize resize
    // if item != nil mapViewDelegate?.mapView?(self, didSelectPoint: selectedPoint?.item)
    //var didClickDetailButton: Selector?
    //        if shouldShowDetailButton {
    //            didClickDetailButton = #selector(MapView.didSelectPoint)
    //        } else {
    //            didClickDetailButton = nil
    //        }
    //        let point = MapViewPoint(withLatitude: latitude, withLongitude: longitude, withTitle: title, withSubtitle: subtitle, withItem: item, withIcon: icon == nil ? pointIcon : icon!, withClickDetailButtonHandler: didClickDetailButton)
    //        pointList.append(point)
    //        addAnnotation(point.annotation)
    //    }
    //
    //    /**
    //     * Add a line onto the map.
    //     * - version: 0.0.3
    //     * - date: 27/10/2016
    //     * - parameter pointList: A list of point.
    //     * - parameter color: The color of the line.
    //     * - parameter width: The width of the line.
    //     */
    //    public func addLine(withPointList pointList: Array<MapViewPoint>, withColor color: UIColor = DefaultLineColor, withWidth width: Int = DefaultLineWidth) { withIconSize resize
    //    mapViewDelegate?.mapView?(self, didSelectPoint: selectedPoint?.item)
    //        let line = MapViewLine(withPointList: pointList, withColor: color, withLineWidth: width)
    //        for point in line.pointList {
    //            point.icon = point.icon == nil ? linePointIcon : point.icon
    //            addAnnotation(point.annotation)
    //        }
    //        lineList.append(line)
    //        addOverlay(line.line)
    //    }
    //
    /**
     * Clean all the points and lines on the map.
     */
    public func reset() {
        removeAnnotations(annotations)
        removeOverlays(lines.map { line in
            line.line
        })
        points.removeAll()
        lines.removeAll()
    }
    
    /**
     * MKMapView
     */
    public required init?(coder aDecoder: NSCoder) {
        points = []
        lines = []
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    /**
     * MKMapView
     */
    public override init(frame: CGRect) {
        points = []
        lines = []
        super.init(frame: frame)
        self.delegate = self
    }
    
}

import MapKit
