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
     * The item presented by the point.
     */
    let item: Any?
    
    /**
     * The view presenting the point.
     */
    var view: MKAnnotationView! {
        didSet {
            view.render(self)
        }
    }
    
    /**
     * The vertical offset of the icon.
     */
    let iconVerticalOffset: Int?
    
    /**
     * The action of the detail button.
     */
    let detailButtonAction: Selector?
    
    /**
     * The icon of the map point.
     */
    let icon: UIImage?
    //
    //    /**
    //     * Initialize the object.
    //     * - version: 0.0.4
    //     * - date: 28/10/2016
    //     * - parameter latitude: The latitude.
    //     * - parameter longitude: The longitude.
    //     * - parameter title: The title.
    //     * - parameter subtitle: The subtitle.
    //     * - parameter item: The item that the point represents.
    //     * - parameter icon: The point icon.
    //     * - parameter didClickDetailButton: The thing to be performed when the detail button is clicked.
    //     * - parameter verticalOffset: The icon vertical offset.
    //     */
    //    init(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String? = nil, withSubtitle subtitle: String? = nil, withItem item: AnyObject? = nil, withIcon icon: UIImage? = nil, withClickDetailButtonHandler didClickDetailButton: Selector? = nil, withIconVerticalOffset verticalOffset: Int? = nil) {
    //        annotation = MKPointAnnotation()
    //        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //        annotation.title = title
    //        annotation.subtitle = subtitle
    //        iconVerticalOffset = verticalOffset
    //        self.item = item
    //        self.icon = icon
    //        self.didClickDetailButton = didClickDetailButton
    //    }
    //
    //    /**
    //     * Initialize the object.
    //     * - version: 0.0.4
    //     * - date: 28/10/2016
    //     * - parameter latitude: The latitude.
    //     * - parameter longitude: The longitude.
    //     * - parameter title: The title.
    //     * - parameter subtitle: The subtitle.
    //     * - parameter icon: The icon of the point.
    //     * - parameter verticalOffset: The icon vertical offset.
    //     */
    //    public init(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String? = nil, withSubtitle subtitle: String? = nil, withIcon icon: UIImage? = nil, withIconVerticalOffset verticalOffset: Int? = nil) {
    //        annotation = MKPointAnnotation()
    //        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //        annotation.title = title
    //        annotation.subtitle = subtitle
    //        iconVerticalOffset = verticalOffset
    //        if icon != nil {
    //            self.icon = icon
    //        }
    //    }
    //    
}

import MapKit
