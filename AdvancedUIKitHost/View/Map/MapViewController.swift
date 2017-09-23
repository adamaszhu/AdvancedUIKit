final class MapViewController: UIViewController {
    
    let pointIcon = UIImage(named: "MapPin")
    let lineIcon = UIImage(named: "MapPoint")
    let collapseIcon = UIImage(named: "ExitFullScreen")
    let lineWidth = 5
    let distancePattern = "%.1f km"
    let distanceColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    let distanceBackgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
    let distanceBackgroundRadius = CGFloat(10)
    let distanceLabelSize = CGSize(width: 100, height: 40)
    let melbournePoint = (latitude: -37.8136, longitude: 144.9631, title: "Melbourne")
    let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 2.0)
    let hawthornPoint = (latitude: -37.826, longitude: 145.0340, title: "Hawthorn", subtitle: "Old Home", item: "Hawthorn")
    let hawthornRegion = (leftLongitude: 145.013461, rightLongitude: 145.04951, topLatitude: -37.810614, bottmLatitude: -37.846985)
    let hawthornRegionColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 0.4)
    let hawthornRegionTitle = (leftTop: "Left Top", rightTop: "Right Top", leftBottom: "Left Bottom", rightBottom: "Right Bottom")
    let bulleenPoint = (latitude: -37.77, longitude: 145.09, title: "Bulleen", subtitle: "Home")
    let bulleenRegion = (leftLongitude: 145.063039, rightLongitude: 145.106654, topLatitude: -37.747502, bottmLatitude: -37.784629)
    let bulleenRegionColor = UIColor(red: 125 / 255, green: 182 / 255, blue: 216 / 255, alpha: 1)
    let collapseIconOrigin = CGPoint(x: 20, y: 20)
    
    @IBOutlet weak var mapView: ExpandableMapView!
    
    lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.center = self.mapView.center
        distanceLabel.bounds.size = self.distanceLabelSize
        distanceLabel.textAlignment = .center
        distanceLabel.textColor = self.distanceColor
        distanceLabel.backgroundColor = self.distanceBackgroundColor
        distanceLabel.layer.cornerRadius = self.distanceBackgroundRadius
        distanceLabel.clipsToBounds = true
        self.mapView.addSubview(distanceLabel)
        return distanceLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapViewDelegate = self
        mapView.isExpandable = true
        mapView.collapseIcon = collapseIcon
        mapView.collapseIconOrigin = collapseIconOrigin
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: melbourneRegion.latitude, withCenterLongitude: melbourneRegion.longitude, withZoomLevel: melbourneRegion.zoomLevel)
    }
    
    @IBAction func pointMelbourne(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: melbournePoint.latitude, longitude: melbournePoint.longitude, title: melbournePoint.title))
    }
    
    @IBAction func showHawthorn(_ sender: Any) {
        mapView.setViewport(withTopLatitude: hawthornRegion.topLatitude, withBottomLatitude: hawthornRegion.bottmLatitude, withLeftLongitude: hawthornRegion.leftLongitude, withRightLongitude: hawthornRegion.rightLongitude)
    }
    
    @IBAction func circleHawthorn(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: hawthornRegion.topLatitude, longitude: hawthornRegion.leftLongitude, title: hawthornRegionTitle.leftTop),
            MapViewPoint(latitude: hawthornRegion.topLatitude, longitude: hawthornRegion.rightLongitude, title: hawthornRegionTitle.rightTop),
            MapViewPoint(latitude: hawthornRegion.bottmLatitude, longitude: hawthornRegion.rightLongitude, title: hawthornRegionTitle.rightBottom),
            MapViewPoint(latitude: hawthornRegion.bottmLatitude, longitude: hawthornRegion.leftLongitude, title: hawthornRegionTitle.leftBottom),
            MapViewPoint(latitude: hawthornRegion.topLatitude, longitude: hawthornRegion.leftLongitude, title: hawthornRegionTitle.leftTop)]
        let line = MapViewLine(points: points, color: hawthornRegionColor, width: lineWidth, pointIcon: lineIcon)
        mapView.add(line)
    }
    
    @IBAction func pointHawthorn(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: hawthornPoint.latitude, longitude: hawthornPoint.longitude, title: hawthornPoint.title, subtitle: hawthornPoint.subtitle, icon: pointIcon, position: .bottomCenter, item: hawthornPoint.item))
    }
    
    @IBAction func showBulleen(_ sender: Any) {
        mapView.setViewport(withTopLatitude: bulleenRegion.topLatitude, withBottomLatitude: bulleenRegion.bottmLatitude, withLeftLongitude: bulleenRegion.leftLongitude, withRightLongitude: bulleenRegion.rightLongitude)
    }
    
    @IBAction func circleBulleen(_ sender: Any) {
        let points = [
            MapViewPoint(latitude: bulleenRegion.topLatitude, longitude: bulleenRegion.leftLongitude),
            MapViewPoint(latitude: bulleenRegion.topLatitude, longitude: bulleenRegion.rightLongitude),
            MapViewPoint(latitude: bulleenRegion.bottmLatitude, longitude: bulleenRegion.rightLongitude),
            MapViewPoint(latitude: bulleenRegion.bottmLatitude, longitude: bulleenRegion.leftLongitude),
            MapViewPoint(latitude: bulleenRegion.topLatitude, longitude: bulleenRegion.leftLongitude)]
        let line = MapViewLine(points: points, color: bulleenRegionColor)
        mapView.add(line)
    }
    
    @IBAction func pointBulleen(_ sender: Any) {
        mapView.add(MapViewPoint(latitude: bulleenPoint.latitude, longitude: bulleenPoint.longitude, title: bulleenPoint.title, subtitle: bulleenPoint.subtitle, icon: pointIcon, position: .bottomCenter))
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
    
}

import AdvancedUIKit
import UIKit
