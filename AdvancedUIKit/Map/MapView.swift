/// A customized MapView with additional actions.
///
/// - author: Adamas
/// - version: 1.4.0
/// - date: 23/08/2018
public class MapView: MKMapView {
    
    /// The default zoom level while showing user's location.
    public static let defaultUserLocationMargin = Double(10)
    
    /// The delegate of the map.
    public weak var mapViewDelegate: MapViewDelegate?
    
    /// The point list.
    private var points: [MapViewPoint] = []
    
    /// The line list.
    private var lines: [MapViewLine] = []
    
    /// The location helper.
    private let locationHelper: LocationHelper = LocationHelper()
    
    /// Set the view of the map.
    ///
    /// - Parameters:
    ///   - latitude: The center latitude of the view.
    ///   - longitude: The center longitude of the view.
    ///   - zoomLevel: The zoom level. If it is nil, zoom level will not be changed.
    ///   - shouldAnimate: Whether the animation should be allowed or not.
    public func setViewport(withCenterLatitude latitude: Double, andCenterLongitude longitude: Double, withZoomLevel zoomLevel: Double? = nil, withAnimation shouldAnimate: Bool = true) {
        let region: MKCoordinateRegion
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
    public func setViewport(withTopLatitude topLatitude: Double, bottomLatitude: Double, leftLongitude: Double, andRightLongitude rightLongitude: Double, withAnimation shouldAnimate: Bool = true) {
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
        setRegion(region, animated: shouldAnimate)
    }
    
    /// Adjust the viewport according to the points and lines within it.
    public func overview() {
        if points.count == 0, lines.count == 0 {
            setViewport(withTopLatitude: 90, bottomLatitude: -90, leftLongitude: -180, andRightLongitude: 180)
            return
        }
        var coordinates = points.map { $0.annotation.coordinate }
        lines.forEach {
            coordinates = coordinates + $0.points.map { $0.annotation.coordinate }
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
        setViewport(withTopLatitude: maxLatitude, bottomLatitude: minLatitude, leftLongitude: minLongitude, andRightLongitude: maxLongitude)
    }
    
    /// Add a point on the map.
    ///
    /// - Parameter point: The point.
    public func add(_ point: MapViewPoint) {
        if let item = point.item {
            point.detailButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
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
            line.points.forEach { addAnnotation($0.annotation) }
        }
    }
    
    /// Request user authorization on always use location.
    public func requestUserLocation() {
        showsUserLocation = locationHelper.isAlwaysAuthorizationAuthorized || locationHelper.isWhenInUseAuthorizationAuthorized
        if locationHelper.isUnauthorized {
            locationHelper.requestAlwaysAuthorization()
        }
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
        setViewport(withCenterLatitude: userLocationCoordinate.latitude, andCenterLongitude: userLocationCoordinate.longitude, withZoomLevel: zoomLevel)
    }
    
    /// Clean all the points and lines on the map.
    public func reset() {
        removeAnnotations(annotations)
        removeOverlays(lines.map { $0.line })
        points.removeAll()
        lines.removeAll()
    }
    
    /// Initialize the object
    private func initialize() {
        self.delegate = self
        locationHelper.locationHelperDelegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialize()
    }
}

/// LocationHelperDelegate
extension MapView: LocationHelperDelegate {
    
    public func locationHelper(_ locationHelper: LocationHelper, didCatchError error: String) {
        mapViewDelegate?.mapView(self, didCatchError: error)
    }
    
    public func locationHelper(_ locationHelper: LocationHelper, didAuthorizeAlwaysAuthorization isAuthorized: Bool) {
        showsUserLocation = true
    }
    
    public func locationHelper(_ locationHelper: LocationHelper, didAuthorizeWhenInUseAuthorization isAuthorized: Bool) {
        showsUserLocation = true
    }
}

/// MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    
    /// Find the point containing the annotation in a list of points.
    ///
    /// - Parameters:
    ///   - annotation: The annotation.
    ///   - list: The point list.
    /// - Returns: The point. Nil if it is not found.
    private func findPoint(with annotation: MKAnnotation, in list: [MapViewPoint]) -> MapViewPoint? {
        return list.first(where: { $0.annotation === annotation })
    }
    
    /// Find the point containing the annotation in a line.
    ///
    /// - Parameter annotation: The annotation.
    /// - Returns: The point. Nil if it is not found.
    private func findLinePoint(with annotation: MKAnnotation) -> MapViewPoint? {
        return lines.compactMap { findPoint(with: annotation, in: $0.points) }.first
    }
    
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let location = userLocation.location else {
            return
        }
        mapViewDelegate?.mapView(self, didUpdate: location)
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewDidMoveView(self)
    }
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapViewDelegate?.mapViewWillMoveView(self)
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusableID = String(describing: MapViewPoint.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: reusableID) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reusableID)
        let point: MapViewPoint
        if let singlePoint = findPoint(with: annotation, in: points) {
            point = singlePoint
        } else if let linePoint = findLinePoint(with: annotation) {
            point = linePoint
        } else {
            Logger.standard.logError(MapView.pointError)
            return nil
        }
        guard let _ = point.icon else {
            // Default pin will be applied.
            return nil
        }
        view.render(point)
        return view
    }
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let line = lines.first(where: { $0.line === overlay }) else {
            Logger.standard.logError(MapView.lineError)
            return MKOverlayRenderer()
        }
        return line.renderer
    }
}

/// Constants
private extension MapView {
    
    /// The default overview margin.
    static let defaultOverviewMargin = Double(0.001)
    
    /// System error.
    static let pointError = "The point doesn't exist."
    static let lineError = "The line doesn't exist."
    
    /// System warning.
    static let userLocationUnretrievedWarning = "The user location hasn't been retrieved yet."
}

import AdvancedFoundation
import MapKit
