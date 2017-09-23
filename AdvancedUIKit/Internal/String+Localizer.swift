/// String+Localizer localizes a string.
///
/// - author: Adamas
/// - version: 1.1.0
/// - date: 11/07/2017
extension String {
    
    /// The default localization file.
    private static let defaultLocalizationFilename = "Localizable"
    
    /// Localize a string within the class using a localization file in the main bundle.
    ///
    /// - Parameter filename: The string file used to localize the string.
    /// - Returns: The localized string.
    func localizedString(withLocalizationFile filename: String = defaultLocalizationFilename) -> String {
        return NSLocalizedString(self, tableName: filename, comment: .empty)
    }
    
    /// Localize a string using the the class name as the localization file within the bundle of a class.
    ///
    /// - Parameter anyClass: The class used to find the localization file.
    /// - Returns: The localized string.
    func localizedString(for anyClass: AnyClass) -> String {
        let bundle = Bundle(for: anyClass)
        return NSLocalizedString(self, tableName: String(describing: anyClass), bundle: bundle, comment: .empty)
    }
    
    /// Localize a string using the localization file as the class name within current framework.
    ///
    /// - Parameter type: Any structure or class used to find the localization file.
    /// - Returns: The localized string.
    func localizedInternalString(forType type: Any) -> String {
        let bundle = Bundle(for: Logger.self)
        return NSLocalizedString(self, tableName: String(describing: type), bundle: bundle, comment: .empty)
    }
    
}

import Foundation

