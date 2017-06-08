class MapViewController: UIViewController {
    
    private let mapIcon = UIImage(named: "MapPin")
    private let melbournePoint = (latitude: -37.8136, longitude: 144.9631, title: "Melbourne")
    private let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 1.0)
    private let hawthornPoint = (latitude: -37.826, longitude: 145.0340, title: "Hawthorn", subtitle: "Home", item: "Hawthorn")
    
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
    
    @IBAction func pointHawthorn(_ sender: Any) {
        mapView.addPoint(MapViewPoint(latitude: hawthornPoint.latitude, longitude: hawthornPoint.longitude, title: hawthornPoint.title, subtitle: hawthornPoint.subtitle, icon: mapIcon, position: .bottomCenter, item: hawthornPoint.item))
    }
    
}

import AdvancedUIKit
import MapKit
import UIKit
