class MapViewController: UIViewController {
    
    private let pointIcon = UIImage(named: "MapPin")
    private let lineIcon = UIImage(named: "MapPoint")
    private let lineWidth = 5
    private let melbournePoint = (latitude: -37.8136, longitude: 144.9631, title: "Melbourne")
    private let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 2.0)
    private let hawthornPoint = (latitude: -37.826, longitude: 145.0340, title: "Hawthorn", subtitle: "Old Home", item: "Hawthorn")
    private let hawthornRegion = (leftLongitude: 145.013461, rightLongitude: 145.04951, topLatitude: -37.810614, bottmLatitude: -37.846985)
    private let hawthornRegionTitle = (leftTop: "Left Top", rightTop: "Right Top", leftBottom: "Left Bottom", rightBottom: "Right Bottom")
    private let bulleenPoint = (latitude: -37.77, longitude: 145.09, title: "Bulleen", subtitle: "Home")
    private let bulleenRegion = (leftLongitude: 145.063039, rightLongitude: 145.106654, topLatitude: -37.747502, bottmLatitude: -37.784629)
    
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapViewDelegate = self
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: melbourneRegion.latitude, withCenterLongitude: melbourneRegion.longitude, withZoomLevel: melbourneRegion.zoomLevel)
    }
    
    @IBAction func pointMelbourne(_ sender: Any) {
        mapView.addPoint(MapViewPoint(latitude: melbournePoint.latitude, longitude: melbournePoint.longitude, title: melbournePoint.title))
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
        let line = MapViewLine(points: points, color: UIColor.red, width: lineWidth, withPointIcon: lineIcon)
        mapView.addLine(line)
    }
    
    @IBAction func pointHawthorn(_ sender: Any) {
        mapView.addPoint(MapViewPoint(latitude: hawthornPoint.latitude, longitude: hawthornPoint.longitude, title: hawthornPoint.title, subtitle: hawthornPoint.subtitle, icon: pointIcon, position: .bottomCenter, item: hawthornPoint.item))
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
        let line = MapViewLine(points: points, color: UIColor.blue)
        mapView.addLine(line)
    }
    
    @IBAction func pointBulleen(_ sender: Any) {
        mapView.addPoint(MapViewPoint(latitude: bulleenPoint.latitude, longitude: bulleenPoint.longitude, title: bulleenPoint.title, subtitle: bulleenPoint.subtitle, icon: pointIcon, position: .bottomCenter))
    }
    
    @IBAction func clean(_ sender: Any) {
        mapView.reset()
    }
    
    @IBAction func overview(_ sender: Any) {
        mapView.overview()
    }
    
}

import AdvancedUIKit
import MapKit
import UIKit
