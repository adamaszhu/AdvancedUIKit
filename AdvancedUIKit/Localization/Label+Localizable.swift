/// Label+Localizable provides localization support for a label.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 31/08/2019
public extension UILabel {
    
    override func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        guard let text = text else {
            return
        }
        self.text = text.localizedString(withLocalizationFile: localizationFile)
    }
}

import UIKit
