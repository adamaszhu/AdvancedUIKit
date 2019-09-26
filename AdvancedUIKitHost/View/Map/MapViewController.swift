final class MapViewController: UIViewController {
    
    private var messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet private weak var mapView: ExpandableMapView!
    
    lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.center = self.mapView.center
        distanceLabel.bounds.size = MapViewController.distanceLabelSize
        distanceLabel.textAlignment = .center
        distanceLabel.textColor = MapViewController.distanceColor
        distanceLabel.backgroundColor = MapViewController.distanceBackgroundColor
        distanceLabel.layer.cornerRadius = MapViewController.distanceBackgroundRadius
        distanceLabel.clipsToBounds = true
        self.mapView.addSubview(distanceLabel)
        return distanceLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapViewDelegate = self
        mapView.isExpandable = true
        mapView.collapseIcon = MapViewController.collapseIcon
        mapView.collapseIconFrame = MapViewController.collapseIconFrame
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: MapViewController.melbourneRegion.latitude, andCenterLongitude: MapViewController.melbourneRegion.longitude, withZoomLevel: MapViewController.melbourneRegion.zoomLevel)
    }
    
    @IBAction func pointMelbourne(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: MapViewController.melbournePoint.latitude, longitude: MapViewController.melbournePoint.longitude, title: MapViewController.melbournePoint.title))
    }
    
    @IBAction func showHawthorn(_ sender: Any) {
        mapView.setViewport(withTopLatitude: MapViewController.hawthornRegion.topLatitude, bottomLatitude: MapViewController.hawthornRegion.bottmLatitude, leftLongitude: MapViewController.hawthornRegion.leftLongitude, andRightLongitude: MapViewController.hawthornRegion.rightLongitude)
    }
    
    @IBAction func circleHawthorn(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: MapViewController.hawthornRegion.topLatitude, longitude: MapViewController.hawthornRegion.leftLongitude, title: MapViewController.hawthornRegionTitle.leftTop),
            MapViewPoint(latitude: MapViewController.hawthornRegion.topLatitude, longitude: MapViewController.hawthornRegion.rightLongitude, title: MapViewController.hawthornRegionTitle.rightTop),
            MapViewPoint(latitude: MapViewController.hawthornRegion.bottmLatitude, longitude: MapViewController.hawthornRegion.rightLongitude, title: MapViewController.hawthornRegionTitle.rightBottom),
            MapViewPoint(latitude: MapViewController.hawthornRegion.bottmLatitude, longitude: MapViewController.hawthornRegion.leftLongitude, title: MapViewController.hawthornRegionTitle.leftBottom),
            MapViewPoint(latitude: MapViewController.hawthornRegion.topLatitude, longitude: MapViewController.hawthornRegion.leftLongitude, title: MapViewController.hawthornRegionTitle.leftTop)]
        let line = MapViewLine(points: points, color: MapViewController.hawthornRegionColor, width: MapViewController.lineWidth, pointIcon: MapViewController.lineIcon)
        mapView.add(line)
    }
    
    @IBAction func pointHawthorn(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: MapViewController.hawthornPoint.latitude, longitude: MapViewController.hawthornPoint.longitude, title: MapViewController.hawthornPoint.title, subtitle: MapViewController.hawthornPoint.subtitle, icon: MapViewController.pointIcon, position: .bottomCenter, item: MapViewController.hawthornPoint.item))
    }
    
    @IBAction func showBulleen(_ sender: Any) {
        mapView.setViewport(withTopLatitude: MapViewController.bulleenRegion.topLatitude, bottomLatitude: MapViewController.bulleenRegion.bottmLatitude, leftLongitude: MapViewController.bulleenRegion.leftLongitude, andRightLongitude: MapViewController.bulleenRegion.rightLongitude)
    }
    
    @IBAction func circleBulleen(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: MapViewController.bulleenRegion.topLatitude, longitude: MapViewController.bulleenRegion.leftLongitude),
            MapViewPoint(latitude: MapViewController.bulleenRegion.topLatitude, longitude: MapViewController.bulleenRegion.rightLongitude),
            MapViewPoint(latitude: MapViewController.bulleenRegion.bottmLatitude, longitude: MapViewController.bulleenRegion.rightLongitude),
            MapViewPoint(latitude: MapViewController.bulleenRegion.bottmLatitude, longitude: MapViewController.bulleenRegion.leftLongitude),
            MapViewPoint(latitude: MapViewController.bulleenRegion.topLatitude, longitude: MapViewController.bulleenRegion.leftLongitude)]
        let line = MapViewLine(points: points, color: MapViewController.bulleenRegionColor)
        mapView.add(line)
    }
    
    @IBAction func pointBulleen(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: MapViewController.bulleenPoint.latitude, longitude: MapViewController.bulleenPoint.longitude, title: MapViewController.bulleenPoint.title, subtitle: MapViewController.bulleenPoint.subtitle, icon: MapViewController.pointIcon, position: .bottomCenter))
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
        distanceLabel.text = String(format: MapViewController.distancePattern, distance)
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
