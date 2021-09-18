#if !os(macOS)
/// Button+Localizable provides localization support for a button.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/08/2019
public extension UIButton {
    
    override func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        guard let title = title else {
            return
        }
        self.title = title.localizedString(withLocalizationFile: localizationFile)
    }
}

import UIKit
#endif
