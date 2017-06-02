/**
 * Label+Localizer provides localization support for a label.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public extension UILabel {
    
    /**
     * UIView
     */
    public override func localize(withLocalizationFile localizationFile: String = defaultLocalizationFile) {
        guard let text = text else {
            return
        }
        self.text = text.localize(withLocalizationFile: localizationFile)
    }
    
}

import UIKit
