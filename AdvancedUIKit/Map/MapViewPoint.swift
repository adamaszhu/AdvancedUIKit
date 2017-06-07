/**
 * MapViewPoint records the information of a point on the map.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public struct MapViewPoint {
    
    /**
     * The annotation.
     */
    let annotation: MKPointAnnotation
    
    /**
     * Where the coordinate point should be in the view. It only works on a customized icon.
     */
    let position: MapViewPointPosition
    
    /**
     * The icon of the map point.
     */
    let icon: UIImage?
    
    /**
     * The item presented by the point.
     */
    let item: Any?
    
    /**
     * The action of the detail button.
     */
    let detailButtonAction: ((Any?) -> Void)?
    
    /**
     * The view presenting the point.
     */
    var view: MKAnnotationView! {
        didSet {
            view.render(self)
        }
    }
    
    /**
     * Initialize the object.
     * - parameter latitude: The latitude.
     * - parameter longitude: The longitude.
     * - parameter icon: The point icon.
     * - parameter position: Where the coordinate point should be in the view.
     * - parameter title: The title.
     * - parameter subtitle: The subtitle.
     * - parameter item: The item that the point represents.
     * - parameter detailButtonAction: The thing to be performed when the detail button is clicked.
     */
    public init(latitude: Double, longitude: Double, icon: UIImage? = nil, position: MapViewPointPosition = .center, title: String? = nil, subtitle: String? = nil, item: Any? = nil, detailButtonAction: ((Any?) -> Void)? = nil) {
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.icon = icon
        self.position = position
        self.item = item
        self.detailButtonAction = detailButtonAction
    }
    
    /**
     * The function to be called when the detailButtonAction need to be invoked.
     */
    func didClickDetailButton() {
        detailButtonAction?(item)
    }
    
}

import MapKit
