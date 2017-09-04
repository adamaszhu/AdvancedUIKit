/// View+Localizer provides localization support for a view.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 02/06/2017
public extension UIView {
    
    /// The default localization file.
    static let defaultLocalizationFile = "Localizable"
    
    /// Localize the view.
    ///
    /// - Parameter localizationFile: The string file where all strings are stored.
    public func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        for view in subviews {
            view.localize(withLocalizationFile: localizationFile)
        }
    }
    
}

import UIKit
