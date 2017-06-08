/**
 * MKAnnotationView+Renderer renders a point.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 07/06/2017
 */
extension MKAnnotationView {
    
    /**
     * The size of the detail button.
     */
    private static let defaultDetailButtonSize = CGFloat(30)
    
    /**
     * Render the annotation.
     * - parameter point: The point presented by the view.
     */
    func render(_ point: MapViewPoint) {
        if let icon = point.icon {
            image = point.icon
            switch point.position {
            case .bottomCenter:
                centerOffset = CGPoint(x: 0, y: -icon.size.height / 2)
                break
            case .center:
                break
            }
        }
        if point.item != nil {
            let detailButton = UIButton(type: .detailDisclosure)
            detailButton.frame = CGRect(x: 0, y: 0, width: MKAnnotationView.defaultDetailButtonSize, height: MKAnnotationView.defaultDetailButtonSize)
            detailButton.addTarget(point, action: #selector(MapViewPoint.didClickDetailButton), for: .touchUpInside)
            rightCalloutAccessoryView = detailButton
        }
        canShowCallout = point.annotation.title != nil
    }
    
}

import MapKit
