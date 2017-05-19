/**
 * String+Localizer localizes a string.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 15/04/2017
 */
extension String {
    
    /**
     * The default localization file.
     */
    private static let defaultLocalizationFile = "Localizable"
    
    /**
     * Localize a string using the localization file as the class name within current framework.
     * - parameter type: Any structure or class used to find the localization file.
     * - returns: The localized string.
     */
    func localizeWithinFramework(forType type: Any) -> String {
        let bundle = Bundle(for: Logger.self)
        return NSLocalizedString(self, tableName: String(describing: type), bundle: bundle, comment: "")
    }
    
}

import Foundation

