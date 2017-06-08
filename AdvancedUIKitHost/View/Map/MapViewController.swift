class MapViewController: UIViewController {
    
    private let melbournePoint = (latitude: -37.8136, longitude: 144.9631, title: "Melbourne")
    private let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 1.0)
    
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: melbourneRegion.latitude, withCenterLongitude: melbourneRegion.longitude, withZoomLevel: melbourneRegion.zoomLevel)
    }
    
    @IBAction func pointMelbourne(_ sender: Any) {
        mapView.addPoint(MapViewPoint(latitude: melbournePoint.latitude, longitude: melbournePoint.longitude, title: melbournePoint.title))
    }
    
}

import AdvancedUIKit
import MapKit
import UIKit
