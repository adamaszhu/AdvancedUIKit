final class MapViewController: UIViewController {
    
    private var messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet private weak var mapView: ExpandableMapView!
    
    lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.center = self.mapView.center
        distanceLabel.bounds.size = Self.distanceLabelSize
        distanceLabel.textAlignment = .center
        distanceLabel.textColor = Self.distanceColor
        distanceLabel.backgroundColor = Self.distanceBackgroundColor
        distanceLabel.layer.cornerRadius = Self.distanceBackgroundRadius
        distanceLabel.clipsToBounds = true
        self.mapView.addSubview(distanceLabel)
        return distanceLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapViewDelegate = self
        mapView.isExpandable = true
        mapView.collapseIcon = Self.collapseIcon
        mapView.collapseIconFrame = Self.collapseIconFrame
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: Self.melbourneRegion.latitude, andCenterLongitude: Self.melbourneRegion.longitude, withZoomLevel: Self.melbourneRegion.zoomLevel)
    }
    
    @IBAction func pointMelbourne(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: Self.melbournePoint.latitude, longitude: Self.melbournePoint.longitude, title: Self.melbournePoint.title))
    }
    
    @IBAction func showHawthorn(_ sender: Any) {
        mapView.setViewport(withTopLatitude: Self.hawthornRegion.topLatitude, bottomLatitude: Self.hawthornRegion.bottmLatitude, leftLongitude: Self.hawthornRegion.leftLongitude, andRightLongitude: Self.hawthornRegion.rightLongitude)
    }
    
    @IBAction func circleHawthorn(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: Self.hawthornRegion.topLatitude, longitude: Self.hawthornRegion.leftLongitude, title: Self.hawthornRegionTitle.leftTop),
            MapViewPoint(latitude: Self.hawthornRegion.topLatitude, longitude: Self.hawthornRegion.rightLongitude, title: Self.hawthornRegionTitle.rightTop),
            MapViewPoint(latitude: Self.hawthornRegion.bottmLatitude, longitude: Self.hawthornRegion.rightLongitude, title: Self.hawthornRegionTitle.rightBottom),
            MapViewPoint(latitude: Self.hawthornRegion.bottmLatitude, longitude: Self.hawthornRegion.leftLongitude, title: Self.hawthornRegionTitle.leftBottom),
            MapViewPoint(latitude: Self.hawthornRegion.topLatitude, longitude: Self.hawthornRegion.leftLongitude, title: Self.hawthornRegionTitle.leftTop)]
        let line = MapViewLine(points: points, color: Self.hawthornRegionColor, width: Self.lineWidth, pointIcon: Self.lineIcon)
        mapView.add(line)
    }
    
    @IBAction func pointHawthorn(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: Self.hawthornPoint.latitude, longitude: Self.hawthornPoint.longitude, title: Self.hawthornPoint.title, subtitle: Self.hawthornPoint.subtitle, icon: Self.pointIcon, position: .bottomCenter, item: Self.hawthornPoint.item))
    }
    
    @IBAction func showBulleen(_ sender: Any) {
        mapView.setViewport(withTopLatitude: Self.bulleenRegion.topLatitude, bottomLatitude: Self.bulleenRegion.bottmLatitude, leftLongitude: Self.bulleenRegion.leftLongitude, andRightLongitude: Self.bulleenRegion.rightLongitude)
    }
    
    @IBAction func circleBulleen(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: Self.bulleenRegion.topLatitude, longitude: Self.bulleenRegion.leftLongitude),
            MapViewPoint(latitude: Self.bulleenRegion.topLatitude, longitude: Self.bulleenRegion.rightLongitude),
            MapViewPoint(latitude: Self.bulleenRegion.bottmLatitude, longitude: Self.bulleenRegion.rightLongitude),
            MapViewPoint(latitude: Self.bulleenRegion.bottmLatitude, longitude: Self.bulleenRegion.leftLongitude),
            MapViewPoint(latitude: Self.bulleenRegion.topLatitude, longitude: Self.bulleenRegion.leftLongitude)]
        let line = MapViewLine(points: points, color: Self.bulleenRegionColor)
        mapView.add(line)
    }
    
    @IBAction func pointBulleen(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: Self.bulleenPoint.latitude, longitude: Self.bulleenPoint.longitude, title: Self.bulleenPoint.title, subtitle: Self.bulleenPoint.subtitle, icon: Self.pointIcon, position: .bottomCenter))
    }
    
    @IBAction func clean(_ sender: Any) {
        mapView.reset()
    }
    
    @IBAction func overview(_ sender: Any) {
        mapView.overview()
    }
    
    @IBAction func showMyLocation(_ sender: Any) {
        mapView.showUserLocation()
    }
    
    private func updateDistance(to coordinate: CLLocationCoordinate2D) {
        let distance = coordinate.distance(to: mapView.centerCoordinate) / 1000
        distanceLabel.text = String(format: Self.distancePattern, distance)
    }
}

extension MapViewController: MapViewDelegate {
    
    func mapView(_ mapView: MapView, didCatchError error: String) {
        messageHelper?.showInfo(error)
    }
    
    func mapView(_ mapView: MapView, didSelectItem item: Any) {
        if let name = item as? String {
            messageHelper?.showInfo(name)
        }
    }
    
    func mapView(_ mapView: MapView, didUpdate location: CLLocation) {
        updateDistance(to: location.coordinate)
    }
    
    func mapViewDidMoveView(_ mapView: MapView) {
        guard mapView.userLocation.coordinate.latitude != 0, mapView.userLocation.coordinate.longitude != 0 else {
            return
        }
        updateDistance(to: mapView.userLocation.coordinate)
    }
}

private extension MapViewController {
    static let pointIcon = UIImage(named: "MapPin")
    static let lineIcon = UIImage(named: "MapPoint")
    static let collapseIcon = UIImage(named: "ExitFullScreen")
    static let lineWidth = 5
    static let distancePattern = "%.1f km"
    static let distanceColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    static let distanceBackgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
    static let distanceBackgroundRadius = CGFloat(10)
    static let distanceLabelSize = CGSize(width: 100, height: 40)
    static let melbournePoint = (latitude: -37.8136, longitude: 144.9631, title: "Melbourne")
    static let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 2.0)
    static let hawthornPoint = (latitude: -37.826, longitude: 145.0340, title: "Hawthorn", subtitle: "Old Home", item: "Hawthorn")
    static let hawthornRegion = (leftLongitude: 145.013461, rightLongitude: 145.04951, topLatitude: -37.810614, bottmLatitude: -37.846985)
    static let hawthornRegionColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 0.4)
    static let hawthornRegionTitle = (leftTop: "Left Top", rightTop: "Right Top", leftBottom: "Left Bottom", rightBottom: "Right Bottom")
    static let bulleenPoint = (latitude: -37.77, longitude: 145.09, title: "Bulleen", subtitle: "Home")
    static let bulleenRegion = (leftLongitude: 145.063039, rightLongitude: 145.106654, topLatitude: -37.747502, bottmLatitude: -37.784629)
    static let bulleenRegionColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    static let collapseIconFrame = CGRect(x: 20, y: 20, width: 100, height: 100)
}

import AdvancedUIKit
import CoreLocation
import UIKit
