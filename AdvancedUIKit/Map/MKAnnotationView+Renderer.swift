/// MKAnnotationView+Renderer renders a point.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
extension MKAnnotationView {
    
    /// Render the annotation.
    ///
    /// - Parameter point: The point presented by the view.
    func render(_ point: MapViewPoint) {
        if let icon = point.icon {
            image = point.icon
            switch point.position {
            case .bottomCenter:
                let size = point.iconSize ?? icon.size
                centerOffset = CGPoint(x: 0, y: -size.height / 2)
                break
            case .center:
                break
            }
        }
        if let _ = point.detailButtonAction {
            let detailButton = UIButton(type: .detailDisclosure)
            detailButton.frame = CGRect(x: 0, y: 0, width: Self.defaultDetailButtonSize, height: Self.defaultDetailButtonSize)
            detailButton.addTarget(point, action: #selector(MapViewPoint.didClickDetailButton), for: .touchUpInside)
            rightCalloutAccessoryView = detailButton
        }
        canShowCallout = point.annotation.title != nil
        if let iconSize = point.iconSize {
            frame.size = iconSize
        }
    }
}

/// Constants
private extension MKAnnotationView {
    
    /// The size of the detail button.
    static let defaultDetailButtonSize = CGFloat(30)
}

import MapKit
