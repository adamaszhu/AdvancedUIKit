import MapKit

/**
 * A customized MapView with additional actions.
 * - author: Adamas
 * - version: 0.0.4
 * - date: 28/10/2016
 */
public class MapView: MKMapView, MKMapViewDelegate {
    
    /**
     * The size of a pin icon.
     */
    public static let DefaultIconSize = Double(40)
    
    /**
     * The size of a pin icon on the line.
     */
    public static let DefaultLineIconSize = Double(20)
    
    /**
     * The reusable map point id.
     */
    private static let MapViewPointID = "MapViewPointID"
    
    /**
     * The width of the line.
     */
    private static let DefaultLineWidth = 2
    
    /**
     * The width of the line.
     */
    private static let DefaultLineColor = UIColor.blackColor()
    
    /**
     * The default size of the viewport.
     */
    private static let DefaultViewportMargin = Double(1)
    
    /**
     * Whether the detail button should be allowed or not.
     */
    public var shouldShowDetailButton: Bool
    
    /**
     * The delegate of the map.
     */
    public var mapViewDelegate: MapViewDelegate?
    
    /**
     * The customized pin icon.
     */
    public var pointIcon: UIImage? {
        /**
         * - version: 0.0.2
         * - date: 12/10/2016
         */
        didSet{
            if pointIcon == nil {
                return
            }
            pointIcon = pointIcon!.resize(toWidth: MapView.DefaultIconSize, toHeight: MapView.DefaultIconSize)
        }
    }
    
    /**
     * The customized pin icon on a line.
     */
    public var linePointIcon: UIImage? {
        /**
         * - version: 0.0.3
         * - date: 27/10/2016
         */
        didSet{
            if linePointIcon == nil {
                return
            }
            linePointIcon = linePointIcon!.resize(toWidth: MapView.DefaultLineIconSize, toHeight: MapView.DefaultLineIconSize)
        }
    }
    
    /**
     * The point list.
     */
    var pointList: Array<MapViewPoint>
    
    /**
     * The line list.
     */
    var lineList: Array<MapViewLine>
    
    /**
     * Selected point.
     */
    var selectedPoint: MapViewPoint?
    
    /**
     * Set the view of the map.
     * - version: 0.0.2
     * - date: 12/10/2016
     * - parameter latitude: The center latitude of the view.
     * - parameter longitude: The center longitude of the view.
     * - parameter zoom: The zoom level.
     * - parameter shouldAnimate: Whether the animation should be allowed or not.
     */
    public func setViewport(withCenterLatitude latitude: Double, withCenterLongitude longitude: Double, withZoomLevel zoom: Int, withAnimation shouldAnimate: Bool = true) {
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        var span = MKCoordinateSpan()
        span.latitudeDelta = 1.0 / Double(zoom)
        span.longitudeDelta = 1.0 / Double(zoom)
        region.span = span
        setRegion(region, animated: shouldAnimate)
    }
    
    /**
     * Adjust the viewport according to the points within it.
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public func adjustViewport() {
        var maxLatitude = Double(-90)
        var minLatitude = Double(90)
        var maxLongitude = Double(-180)
        var minLongitude = Double(180)
        switch annotations.count {
        case 0:
            maxLatitude = 90
            minLatitude = -90
            maxLongitude = 180
            minLongitude = -180
        default:
            var pointLatitude = Double(0)
            var pointLongitude = Double(0)
            for index in 0 ..< annotations.count {
                pointLatitude = annotations[index].coordinate.latitude
                pointLongitude = annotations[index].coordinate.longitude
                minLatitude = pointLatitude < minLatitude ? pointLatitude : minLatitude
                maxLatitude = pointLatitude > maxLatitude ? pointLatitude : maxLatitude
                minLongitude = pointLongitude < minLongitude ? pointLongitude : minLongitude
                maxLongitude = pointLongitude > maxLongitude ? pointLongitude : maxLongitude
            }
        }
        maxLatitude = maxLatitude + MapView.DefaultViewportMargin / 2
        maxLatitude = maxLatitude > 90 ? 90 : maxLatitude
        minLatitude = minLatitude - MapView.DefaultViewportMargin / 2
        minLatitude = minLatitude < -90 ? -90 : minLatitude
        maxLongitude = maxLongitude + MapView.DefaultViewportMargin / 2
        maxLongitude = maxLongitude > 180 ? 180 : maxLongitude
        minLongitude = minLongitude - MapView.DefaultViewportMargin / 2
        minLongitude = minLongitude < -180 ? -180 : minLongitude
        setViewport(withTopLatitude: maxLatitude, withBottomLatitude: minLatitude, withLeftLongitude: minLongitude, withRightLongitude: maxLongitude)
    }
    
    
    /**
     * Set the view of the map.
     * - version: 0.0.2
     * - date: 12/10/2016
     * - parameter topLatitude: The top latitude.
     * - parameter bottomLatitude: The bottom latitude.
     * - parameter leftLongitude: The left longitude.
     * - parameter rightLongitude: The right longitude.
     * - parameter shouldAnimate: Whether the animation should be performed or not.
     */
    public func setViewport(withTopLatitude topLatitude: Double, withBottomLatitude bottomLatitude: Double, withLeftLongitude leftLongitude: Double, withRightLongitude rightLongitude: Double, withAnimation shouldAnimate: Bool = true) {
        // TODO: Consider about special map situation.
        var centerLatitude = (topLatitude + bottomLatitude) / 2
        centerLatitude = centerLatitude == 0 ? 0.001 : centerLatitude
        var centerLongitude = (leftLongitude + rightLongitude) / 2
        centerLongitude = centerLongitude == 0 ? 0.001 : centerLongitude
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        var span = MKCoordinateSpan()
        span.latitudeDelta = topLatitude - bottomLatitude
        span.longitudeDelta = rightLongitude - leftLongitude
        let pointIconWidth = pointIcon == nil ? 0 : pointIcon!.size.width
        let pointIconHeight = pointIcon == nil ? 0 : pointIcon!.size.height
        // COMMENT: Change ratio according to the ratio of the view.
        let ratio = (frame.size.height - pointIconHeight) / (frame.size.width - pointIconWidth)
        if ((span.latitudeDelta / span.longitudeDelta) > Double(ratio)) {
            span.longitudeDelta = span.latitudeDelta / Double(ratio);
        } else {
            span.latitudeDelta = Double(ratio) * span.longitudeDelta;
        }
        // COMMENT: Give the margin space to the icon.
        // COMMENT: self.frame.size.height / (self.frame.size.height - _pointIcon.size.height) > self.frame.size.width / (self.frame.size.width - _pointIcon.size.width)
        let frameRadio = ratio * pointIconWidth / pointIconHeight < 1 ?  frame.size.height / (frame.size.height - pointIconHeight) : frame.size.width / (frame.size.width - pointIconWidth)
        span.latitudeDelta *= Double(frameRadio);
        span.longitudeDelta *= Double(frameRadio);
        span.latitudeDelta = span.latitudeDelta > 90 ? 90 : span.latitudeDelta;
        span.longitudeDelta = span.longitudeDelta > 360 ? 360 : span.longitudeDelta;
        region.span = span;
        // COMMENT: Set offset according to the icon.
        let fixedLatitude = Double(region.center.latitude) + region.span.latitudeDelta * Double(pointIconHeight) / 2 / Double(frame.size.height)
        region.center = CLLocationCoordinate2D(latitude: fixedLatitude, longitude: region.center.longitude)
        self.setRegion(region, animated: shouldAnimate)
    }
    
    /**
     * Add a point on the map.
     * - version: 0.0.3
     * - date: 27/10/2016
     * - parameter latitude: The latitude of the point.
     * - parameter longitude: The longitude of the point.
     * - parameter title: The title of the point.
     * - parameter subtitle: The subtitle of the point.
     * - parameter item: The item attached to the point.
     * - parameter icon: The icon of the point.
     */
    public func addPoint(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String, withSubtitle subtitle: String, withItem item: AnyObject? = nil, withIcon icon: UIImage? = nil) {
        var didClickDetailButton: Selector?
        if shouldShowDetailButton {
            didClickDetailButton = #selector(MapView.didSelectPoint)
        } else {
            didClickDetailButton = nil
        }
        let point = MapViewPoint(withLatitude: latitude, withLongitude: longitude, withTitle: title, withSubtitle: subtitle, withItem: item, withIcon: icon == nil ? pointIcon : icon!, withClickDetailButtonHandler: didClickDetailButton)
        pointList.append(point)
        addAnnotation(point.annotation)
    }
    
    /**
     * Add a line onto the map.
     * - version: 0.0.3
     * - date: 27/10/2016
     * - parameter pointList: A list of point.
     * - parameter color: The color of the line.
     * - parameter width: The width of the line.
     */
    public func addLine(withPointList pointList: Array<MapViewPoint>, withColor color: UIColor = DefaultLineColor, withWidth width: Int = DefaultLineWidth) {
        let line = MapViewLine(withPointList: pointList, withColor: color, withLineWidth: width)
        for point in line.pointList {
            point.icon = point.icon == nil ? linePointIcon : point.icon
            addAnnotation(point.annotation)
        }
        lineList.append(line)
        addOverlay(line.line)
    }
    
    /**
     * Clean all the points on the map.
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public func reset() {
        removeAnnotations(annotations)
        pointList.removeAll()
        lineList.removeAll()
    }
    
    /**
     * The action to be performed when the detail button of a point is clicked.
     * - version: 0.0.2
     * - date: 12/10/2016
     */
    func didSelectPoint() {
        mapViewDelegate?.mapView?(self, didSelectPoint: selectedPoint?.item)
    }
    
    /**
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public required init?(coder aDecoder: NSCoder) {
        shouldShowDetailButton = false
        pointList = []
        lineList = []
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    /**
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public override init(frame: CGRect) {
        shouldShowDetailButton = false
        pointList = []
        lineList = []
        super.init(frame: frame)
        self.delegate = self
    }
    
    /**
     * - version: 0.0.2
     * - date: 12/10/2016
     */
    public func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewDidMoveView?(self)
    }
    
    /**
     * - version: 0.0.2
     * - date: 12/10/2016
     */
    public func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewWillMoveView?(self)
    }
    
    /**
     * - version: 0.0.2
     * - date: 12/10/2016
     */
    public func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        for point in pointList {
            if point.view === view {
                selectedPoint = point
                return
            }
        }
    }
    
    /**
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(MapView.MapViewPointID)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapView.MapViewPointID)
        }
        var mapViewPoint: MapViewPoint?
        // COMMENT: Try to find the point in the point list.
        for point in pointList {
            if point.annotation === annotation {
                mapViewPoint = point
                break
            }
        }
        // COMMENT: Try to find the point in the line list.
        for line in lineList {
            for point in line.pointList {
                if point.annotation === annotation {
                    mapViewPoint = point
                    break
                }
            }
        }
        mapViewPoint?.renderView(annotationView!)
        return annotationView
    }
    
    /**
     * - version: 0.0.3
     * - date: 27/10/2016
     */
    public func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        // COMMENT: Try to find the point in the line list.
        var mapViewLine: MapViewLine?
        for line in lineList {
            if line.line === overlay {
                mapViewLine = line
                break
            }
        }
        if mapViewLine == nil {
            return MKOverlayRenderer()
        }
        return mapViewLine!.renderer
    }
}
