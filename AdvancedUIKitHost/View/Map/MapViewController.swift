class MapViewController: UIViewController {
    
    private let melbourneRegion = (latitude: -37.8136, longitude: 144.9631, zoomLevel: 1.0)
    
    @IBOutlet weak var mapView: MapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showMelbourne(_ sender: Any) {
        mapView.setViewport(withCenterLatitude: melbourneRegion.latitude, withCenterLongitude: melbourneRegion.longitude, withZoomLevel: melbourneRegion.zoomLevel)
    }
    
}

import AdvancedUIKit
import MapKit
import UIKit
