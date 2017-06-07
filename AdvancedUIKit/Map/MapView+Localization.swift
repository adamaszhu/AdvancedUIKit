import UIKit

/**
 * MapView+Localization is used to localize the string on the map points.
 * - author: Adamas
 * - version: 0.0.2
 * - date: 27/10/2016
 */
public extension MapView {
    
    /**
     * Localize the string within the points.
     * - version: 0.0.1
     * - date: 12/10/2016
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public override func localize(withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        for point in pointList {
            point.annotation.title = point.annotation.title?.localize(withLocalizationFile: filename)
            point.annotation.subtitle = point.annotation.title?.localize(withLocalizationFile: filename)
        }
    }
    
    /**
     * Add a localized point on the map.
     * - version: 0.0.2
     * - date: 27/10/2016
     * - parameter latitude: The latitude of the point.
     * - parameter longitude: The longitude of the point.
     * - parameter title: The title of the point.
     * - parameter subtitle: The subtitle of the point.
     * - parameter item: The item attached to the point.
     * - parameter icon: The icon of the image.
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public func addLocalizedPoint(withLatitude latitude: Double, withLongitude longitude: Double, withTitle title: String, withSubtitle subtitle: String, withItem item: AnyObject? = nil, withIcon icon: UIImage? = nil, withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        let localizedTitle = title.localize(withLocalizationFile: filename)
        let localizedSubtitle = subtitle.localize(withLocalizationFile: filename)
        addPoint(withLatitude: latitude, withLongitude: longitude, withTitle: localizedTitle, withSubtitle: localizedSubtitle, withItem: item, withIcon: icon)
    }
    
}





