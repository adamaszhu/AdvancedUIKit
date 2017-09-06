/// A customized MapView with additional actions.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 07/06/2017
public class MapView: MKMapView {
    
    /// The default overview margin.
    private static let defaultOverviewMargin = Double(0.001)
    
    /// The default zoom level while showing user's location.
    private static let defaultUserLocationMargin = Double(10)
    
    /// System warning.
    private static let userLocationUnretrievedWarning = "The user location hasn't been retrieved yet."
    
    /// The delegate of the map.
    public var mapViewDelegate: MapViewDelegate?
    
    /// The point list.
    var points: Array<MapViewPoint>
    
    /// The line list.
    var lines: Array<MapViewLine>
    
    /// The location helper.
    private let locationHelper: LocationHelper
    
    /// Set the view of the map.
    ///
    /// - Parameters:
    ///   - latitude: The center latitude of the view.
    ///   - longitude: The center longitude of the view.
    ///   - zoomLevel: The zoom level. If it is nil, zoom level will not be changed.
    ///   - shouldAnimate: Whether the animation should be allowed or not.
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
    
    /// Set the view of the map.
    /// - Parameters:
    ///   - topLatitude: The top latitude.
    ///   - bottomLatitude: The bottom latitude.
    ///   - leftLongitude: The left longitude.
    ///   - rightLongitude: The right longitude.
    ///   - shouldAnimate: Whether the animation should be performed or not.
    public func setViewport(withTopLatitude topLatitude: Double, withBottomLatitude bottomLatitude: Double, withLeftLongitude leftLongitude: Double, withRightLongitude rightLongitude: Double, withAnimation shouldAnimate: Bool = true) {
        let centerLatitude = (topLatitude + bottomLatitude) / 2
        let centerLongitude = (leftLongitude + rightLongitude) / 2
        var latitudeDelta = topLatitude - bottomLatitude
        var longitudeDelta = rightLongitude - leftLongitude
        // COMMENT: Change ratio according to the ratio of the view.
        let ratio = Double(frame.size.height / frame.size.width)
        if ((latitudeDelta / longitudeDelta) > ratio) {
            longitudeDelta = latitudeDelta / ratio
        } else {
            latitudeDelta = longitudeDelta * ratio
        }
        latitudeDelta = min(90, latitudeDelta)
        longitudeDelta = min(360, longitudeDelta)
        let region = MKCoordinateRegion(centerLatitude: centerLatitude, centerLongitude: centerLongitude, latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        self.setRegion(region, animated: shouldAnimate)
    }
    
    /// Adjust the viewport according to the points and lines within it.
    public func overview() {
        if (points.count == 0) && (lines.count == 0) {
            setViewport(withTopLatitude: 90, withBottomLatitude: -90, withLeftLongitude: -180, withRightLongitude: 180)
            return
        }
        var coordinates = self.points.map { point in
            point.annotation.coordinate
        }
        for line in lines {
            coordinates = coordinates + line.points.map { point in
                point.annotation.coordinate
            }
        }
        var maxLatitude = Double(-90)
        var minLatitude = Double(90)
        var maxLongitude = Double(-180)
        var minLongitude = Double(180)
        for coordinate in coordinates {
            maxLatitude = max(maxLatitude, coordinate.latitude)
            minLatitude = min(minLatitude, coordinate.latitude)
            maxLongitude = max(maxLongitude, coordinate.longitude)
            minLongitude = min(minLongitude, coordinate.longitude)
        }
        maxLatitude = min(90, maxLatitude + MapView.defaultOverviewMargin)
        minLatitude = max(-90, minLatitude - MapView.defaultOverviewMargin)
        maxLongitude = min(180, maxLongitude + MapView.defaultOverviewMargin)
        minLongitude = max(-180, minLongitude - MapView.defaultOverviewMargin)
        setViewport(withTopLatitude: maxLatitude, withBottomLatitude: minLatitude, withLeftLongitude: minLongitude, withRightLongitude: maxLongitude)
    }
    
    /// Add a point on the map.
    ///
    /// - Parameter point: The point.
    public func addPoint(_ point: MapViewPoint) {
        if let item = point.item {
            point.detailButtonAction = { [unowned self] _ in
                self.mapViewDelegate?.mapView(self, didSelectItem: item)
            }
        }
        points.append(point)
        addAnnotation(point.annotation)
    }
    
    /// Add a line onto the map.
    ///
    /// - Parameter line: The line to be presented.
    public func addLine(_ line: MapViewLine) {
        lines.append(line)
        add(line.line)
        if line.pointIcon != nil {
            for point in line.points {
                addAnnotation(point.annotation)
            }
        }
    }
    
    /// Request user authorization on always use location.
    public func requestUserLocation() {
        guard LocationHelper.isAlwaysAuthorizationAuthorized || LocationHelper.isWhenInUseAuthorizationAuthorized else {
            locationHelper.requestAlwaysAuthorization()
            return
        }
        showsUserLocation = true
    }
    
    /// Show current location.
    ///
    /// - Parameter zoomLevel: The zoom level while showing user's location.
    public func showUserLocation(withZoomLevel zoomLevel: Double = defaultUserLocationMargin) {
        requestUserLocation()
        guard showsUserLocation else {
            // COMMENT: The authorization is declined.
            return
        }
        let userLocationCoordinate = userLocation.coordinate
        guard (userLocationCoordinate.latitude != 0) && (userLocationCoordinate.longitude != 0) else {
            Logger.standard.log(warning: MapView.userLocationUnretrievedWarning)
            return
        }
        setViewport(withCenterLatitude: userLocationCoordinate.latitude, withCenterLongitude: userLocationCoordinate.longitude, withZoomLevel: zoomLevel)
    }
    
    /// Clean all the points and lines on the map.
    public func reset() {
        removeAnnotations(annotations)
        removeOverlays(lines.map { line in
            line.line
        })
        points.removeAll()
        lines.removeAll()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        points = []
        lines = []
        locationHelper = LocationHelper()
        super.init(coder: aDecoder)
        self.delegate = self
        locationHelper.locationHelperDelegate = self
    }
    
    public override init(frame: CGRect) {
        points = []
        lines = []
        locationHelper = LocationHelper()
        super.init(frame: frame)
        self.delegate = self
        locationHelper.locationHelperDelegate = self
    }
    
}

import MapKit
