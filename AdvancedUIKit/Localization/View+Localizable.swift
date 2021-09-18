#if !os(macOS)
/// View+Localizable provides localization support for a view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/08/2019
public extension UIView {
    
    /// The default localization file.
    static let defaultLocalizationFile = "Localizable"
    
    /// Localize the view.
    ///
    /// - Parameter localizationFile: The string file where all strings are stored.
    @objc func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        subviews.forEach {
            $0.localize(withLocalizationFile: localizationFile)
        }
    }
}

import UIKit
#endif
