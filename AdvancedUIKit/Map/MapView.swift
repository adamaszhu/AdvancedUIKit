/// A customized MapView with additional actions.
///
/// - author: Adamas
/// - version: 1.4.0
/// - date: 23/08/2018
public class MapView: MKMapView {
    
    /// The delegate of the map.
    public var mapViewDelegate: MapViewDelegate?
    
    /// The point list.
    var points: [MapViewPoint]
    
    /// The line list.
    var lines: [MapViewLine]
    
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
        // Change ratio according to the ratio of the view.
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
        if points.count == 0, lines.count == 0 {
            setViewport(withTopLatitude: 90, withBottomLatitude: -90, withLeftLongitude: -180, withRightLongitude: 180)
            return
        }
        var coordinates = self.points.map { point in
            point.annotation.coordinate
        }
        lines.forEach {
            coordinates = coordinates + $0.points.map {
                $0.annotation.coordinate
            }
        }
        var maxLatitude = Double(-90)
        var minLatitude = Double(90)
        var maxLongitude = Double(-180)
        var minLongitude = Double(180)
        coordinates.forEach {
            maxLatitude = max(maxLatitude, $0.latitude)
            minLatitude = min(minLatitude, $0.latitude)
            maxLongitude = max(maxLongitude, $0.longitude)
            minLongitude = min(minLongitude, $0.longitude)
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
    public func add(_ point: MapViewPoint) {
        if let item = point.item {
            point.detailButtonAction = { [unowned self] in
                self.mapViewDelegate?.mapView(self, didSelectItem: item)
            }
        }
        points.append(point)
        addAnnotation(point.annotation)
    }
    
    /// Add a line onto the map.
    ///
    /// - Parameter line: The line to be presented.
    public func add(_ line: MapViewLine) {
        lines.append(line)
        add(line.line)
        if let _ = line.pointIcon {
            line.points.forEach {
                addAnnotation($0.annotation)
            }
        }
    }
    
    /// Request user authorization on always use location.
    public func requestUserLocation() {
        guard locationHelper.isAlwaysAuthorizationAuthorized || locationHelper.isWhenInUseAuthorizationAuthorized else {
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
            // The authorization is declined.
            return
        }
        let userLocationCoordinate = userLocation.coordinate
        guard userLocationCoordinate.latitude != 0, userLocationCoordinate.longitude != 0 else {
            Logger.standard.logWarning(MapView.userLocationUnretrievedWarning)
            return
        }
        setViewport(withCenterLatitude: userLocationCoordinate.latitude, withCenterLongitude: userLocationCoordinate.longitude, withZoomLevel: zoomLevel)
    }
    
    /// Clean all the points and lines on the map.
    public func reset() {
        removeAnnotations(annotations)
        removeOverlays(lines.map {
            $0.line
        })
        points.removeAll()
        lines.removeAll()
    }
    
    /// Initialize the object
    private func initialize() {
        self.delegate = self
        locationHelper.locationHelperDelegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        points = []
        lines = []
        locationHelper = LocationHelper()
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        points = []
        lines = []
        locationHelper = LocationHelper()
        super.init(frame: frame)
        initialize()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialize()
    }
    
}

import AdvancedFoundation
import MapKit
