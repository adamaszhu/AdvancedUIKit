/// Button+Localizer provides localization support for a button.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 02/06/2017
public extension UIButton {
    
    public override func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        guard let title = title else {
            return
        }
        self.title = title.localize(withLocalizationFile: localizationFile)
    }
    
}

import UIKit
