import MapKit

/**
 * ExpandableMapView is used to add full screen function to the map view.
 * - author: Adamas
 * - version: 0.0.7
 * - date: 27/10/2016
 */
public class ExpandableMapView: MapView, MapViewDelegate {
    
    /**
     * The icon of the fold button.
     */
    public var foldButtonImage: UIImage {
        /**
         * - version: 0.0.6
         * - date: 12/10/2016
         */
        didSet {
            foldButton.setImage(foldButtonImage, forState: .Normal)
        }
    }
    
    /**
     * The frame of the fold button.
     */
    public var foldButtonFrame: CGRect {
        /**
         * - version: 0.0.6
         * - date: 12/10/2016
         */
        didSet {
            foldButton.frame = foldButtonFrame
        }
    }
    
    /**
     * Whether the fold button should have shadow effect or not.
     */
    public var shouldShowFoldButtonShadow: Bool {
        /**
         * - version: 0.0.6
         * - date: 12/10/2016
         */
        didSet {
            foldButton.layer.shadowColor = UIColor.blackColor().CGColor
            foldButton.layer.shadowOffset = CGSize(width: 2, height: 2)
            foldButton.layer.shadowRadius = 1
            foldButton.layer.shadowOpacity = shouldShowFoldButtonShadow ? 0.2 : 0
        }
    }
    
    /**
     * The fold button.
     */
    private var foldButton: UIButton
    
    /**
     * The full screen map.
     */
    private var mapView: MapView
    
    /**
     * The region of the map before being expanded.
     */
    private var originalRegion: MKCoordinateRegion
    
    /**
     * Whether the full screen map view is loading or not.
     */
    private var isLoading: Bool
    
    /**
     * Whether the expanded map should zoom out first before folding or not.
     */
    private var shouldZoomOut: Bool
    
    /**
     * Whether the full screen view is being reseted to its original region or not.
     */
    private var isReseting: Bool
    
    /**
     * Whether the region of the full screen view should be reseted or not.
     */
    private var shouldReset: Bool
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    required public init?(coder aDecoder: NSCoder) {
        mapView = MapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        originalRegion = MKCoordinateRegion()
        isLoading = false
        isReseting = false
        shouldReset = false
        shouldZoomOut = false
        foldButtonImage = UIImage()
        foldButtonFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        foldButton = UIButton()
        shouldShowFoldButtonShadow = false
        super.init(coder: aDecoder)
        mapView.mapViewDelegate = self
        let tapView = UIView(frame: bounds)
        addSubview(tapView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(enterFullScreen))
        tapView.addGestureRecognizer(tapGesture)
        tapView.disableSwipeGesture()
        tapView.disablePanGesture()
        foldButton.addTarget(self, action: #selector(exitFullScreen), forControlEvents: UIControlEvents.TouchUpInside)
        foldButton.disablePanGesture()
        foldButton.disableSwipeGesture()
        foldButton.hidden = true
        mapView.addSubview(foldButton)
    }
    
    /**
     * Enter full screen mode.
     * - version: 0.0.7
     * - date: 27/10/2016
     */
    public override func enterFullScreen() {
        if isLoading {
            return
        }
        mapView.shouldShowDetailButton = shouldShowDetailButton
        for point in mapView.pointList {
            point.icon = point.icon == nil ? pointIcon : point.icon
        }
        // COMMENT: Try to find the point in the line list.
        for line in lineList {
            for point in line.pointList {
                point.icon = point.icon == nil ? linePointIcon : point.icon
            }
        }
        mapView.frame = superview!.convertRect(frame, toView: window)
        mapView.region = region
        // COMMENT: Waiting for the map loading.
        isLoading = true
        mapView.alpha = 1
        window!.addSubview(mapView)
        performSelector(#selector(performFullScreenAnimation), withObject: self, afterDelay: 0.5)
    }
    
    /**
     * Exit full screen mode.
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public override func exitFullScreen() {
        foldButton.hidden = true
        if !shouldReset {
            performExitFullScreenAnimation()
        } else {
            isReseting = true
            // COMMENT: Whether the view is out of animation range or not.
            var rect = mapRect(ofRegion: originalRegion)
            let intersection = MKMapRectIntersection(rect, mapView.visibleMapRect)
            if MKMapRectIsNull(intersection) {
                shouldZoomOut = true
                rect = MKMapRectUnion(rect, mapView.visibleMapRect)
            }
            mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    /**
     * Convert the region to a map rect.
     * - version: 0.0.6
     * - date: 12/10/2016
     * - parameter region: The region to be converted.
     * - returns: The rect.
     */
    private func mapRect(ofRegion region: MKCoordinateRegion) -> MKMapRect {
        let pointA = MKMapPointForCoordinate(CLLocationCoordinate2D(latitude: region.center.latitude + region.span.latitudeDelta / 2, longitude: region.center.longitude - region.span.longitudeDelta / 2))
        let pointB = MKMapPointForCoordinate(CLLocationCoordinate2D(latitude: region.center.latitude - region.span.latitudeDelta / 2, longitude: region.center.longitude + region.span.longitudeDelta / 2))
        return MKMapRectMake(min(pointA.x, pointB.x), min(pointA.y, pointB.y), abs(pointA.x - pointB.x), abs(pointA.y - pointB.y))
    }
    
    /**
     * Perform the entering animation.
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    @objc public override func performFullScreenAnimation() {
        isLoading = false
        mapView.alpha = 1
        UIView.animate(withChange: {
            self.mapView.frame = self.window!.frame
            }, withPreparationHandle: nil, withCompletionHandle: {
                self.originalRegion = self.mapView.region
                self.shouldReset = false
                self.foldButton.hidden = false
        })
    }
    
    /**
     * Perform the exiting animation.
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    private func performExitFullScreenAnimation() {
        UIView.animate(withChange: {
            self.mapView.frame = self.superview!.convertRect(self.frame, toView: self.window)
            }, withPreparationHandle: nil, withCompletionHandle: {
                self.mapView.removeFromSuperview()
        })
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public override func setRegion(region: MKCoordinateRegion, animated: Bool) {
        super.setRegion(region, animated: animated)
        mapView.setRegion(region, animated: animated)
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public override func addPoint(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String, withSubtitle subtitle: String, withItem item: AnyObject? = nil, withIcon icon: UIImage? = nil) {
        super.addPoint(withLatitude: latitude, withLongitude: longitude, withTitle: title, withSubtitle: subtitle, withItem: item, withIcon: icon)
        mapView.addPoint(withLatitude: latitude, withLongitude: longitude, withTitle: title, withSubtitle: subtitle, withItem: item, withIcon: icon)
    }
    
    /**
     * - version: 0.0.7
     * - date: 27/10/2016
     */
    public override func addLine(withPointList pointList: Array<MapViewPoint>, withColor color: UIColor, withWidth width: Int) {
        super.addLine(withPointList: pointList, withColor: color, withWidth: width)
        mapView.addLine(withPointList: pointList, withColor: color, withWidth: width)
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public override func reset() {
        super.reset()
        mapView.reset()
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public func mapView(mapView: MapView, didSelectPoint pointItem: AnyObject?) {
        mapViewDelegate?.mapView?(mapView, didSelectPoint: pointItem)
        // TODO: This should just be hide.
        mapView.removeFromSuperview()
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public func mapViewWillMoveView(mapView: MapView) {
        if !isReseting {
            shouldReset = true
        }
    }
    
    /**
     * - version: 0.0.6
     * - date: 12/10/2016
     */
    public func mapViewDidMoveView(mapView: MapView) {
        if shouldZoomOut {
            shouldZoomOut = false
            mapView.setRegion(originalRegion, animated: true)
            return
        }
        if isReseting {
            isReseting = false
            performExitFullScreenAnimation()
        }
    }
    
}
