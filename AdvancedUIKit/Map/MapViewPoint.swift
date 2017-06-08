/**
 * MapViewPoint records the information of a point on the map.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
public class MapViewPoint {
    
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
    var icon: UIImage?
    
    /**
     * The item presented by the point.
     */
    let item: Any?
    
    /**
     * The action of the detail button. It only works if the item is not nil.
     */
    var detailButtonAction: (() -> Void)?
    
    /**
     * Initialize the object.
     * - parameter latitude: The latitude.
     * - parameter longitude: The longitude.
     * - parameter title: The title.
     * - parameter subtitle: The subtitle.
     * - parameter icon: The point icon.
     * - parameter position: Where the coordinate point should be in the view.
     * - parameter item: The item that the point represents.
     */
    public init(latitude: Double, longitude: Double, title: String? = nil, subtitle: String? = nil, icon: UIImage? = nil, position: MapViewPointPosition = .center, item: Any? = nil) {
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.icon = icon
        self.position = position
        self.item = item
    }
    
    /**
     * The function to be called when the detailButtonAction need to be invoked.
     */
    @objc func didClickDetailButton() {
        detailButtonAction?()
    }
    
}

import MapKit
