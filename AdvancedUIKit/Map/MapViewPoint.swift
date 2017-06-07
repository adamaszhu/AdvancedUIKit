//import MapKit
//
///**
// * MapViewPoint record the information of a point on the map.
// * - author: Adamas
// * - version: 0.0.4
// * - date: 28/10/2016
// */
public class MapViewPoint: AnyObject {
//
//    /**
//     * The size of the detail button.
//     */
//    private static let DefaultDetailButtonSize = CGFloat(30)
//    
//    /**
//     * The annotation of the point.
//     */
//    private(set) var annotation: MKPointAnnotation
//    
//    /**
//     * The item attached to the point.
//     */
//    private (set) var item: AnyObject?
//    
//    /**
//     * The view of the point.
//     */
//    private (set) var view: MKAnnotationView?
//    
//    /**
//     * The vertical offset of the icon.
//     */
//    private (set) var iconVerticalOffset: Int?
//    
//    /**
//     * The action of the detail button.
//     */
//    var didClickDetailButton: Selector?
//    
//    /**
//     * The icon of the map point.
//     */
//    var icon: UIImage?
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
//    /**
//     * Render the annotation.
//     * - version: 0.0.4
//     * - date: 28/10/2016
//     * - parameter view: The view to be render.
//     */
//    func renderView(view: MKAnnotationView) {
//        self.view = view
//        if iconVerticalOffset != nil {
//            view.centerOffset = CGPoint(x: 0, y: iconVerticalOffset!)
//        } else if icon != nil {
//            view.centerOffset = CGPoint(x: 0, y: -icon!.size.height / 2)
//        }
//        // COMMENT: Set icon.
//        view.image = icon
//        if didClickDetailButton != nil {
//            // COMMENT: Show the show detail button.
//            let detailButton = UIButton(type: UIButtonType.DetailDisclosure)
//            detailButton.frame = CGRectMake(0, 0, MapViewPoint.DefaultDetailButtonSize, MapViewPoint.DefaultDetailButtonSize)
//            detailButton.addTarget(self, action: didClickDetailButton!, forControlEvents: UIControlEvents.TouchUpInside)
//            view.rightCalloutAccessoryView = detailButton
//        }
//        view.canShowCallout = true
//    }
//    
}
