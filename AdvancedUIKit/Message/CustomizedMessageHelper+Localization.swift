import UIKit

/**
 * CustomizedMessageHelper+Localization is used to localize a message.
 * - author: Adamas
 * - version: 0.0.1
 * - date: 18/10/2016
 */
public extension CustomizedMessageHelper {
    /**
     * Popup an information message.
     * - version: 0.0.1
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content.
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public func showLocalizedInfo(withTitle title: String = SuccessTitle, withContent content: String, withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        let localizedTitle = title.localize(withLocalizationFile: filename)
        let localizedContent = content.localize(withLocalizationFile: filename)
        showLocalizedInfo(withTitle: localizedTitle, withContent: localizedContent)
    }
    
    /**
     * Popup a warning message.
     * - version: 0.0.1
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public func showLocalizedWarning(withTitle title: String = WarningTitle, withContent content: String, withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        let localizedTitle = title.localize(withLocalizationFile: filename)
        let localizedContent = content.localize(withLocalizationFile: filename)
        showWarning(withTitle: localizedTitle, withContent: localizedContent)
    }
    
    /**
     * Popup an error message.
     * - version: 0.0.1
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public func showLocalizedError(withTitle title: String = ErrorTitle, withContent content: String, withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        let localizedTitle = title.localize(withLocalizationFile: filename)
        let localizedContent = content.localize(withLocalizationFile: filename)
        showError(withTitle: localizedTitle, withContent: localizedContent)
    }
    
    /**
     * Show an input box.
     * - version: 0.0.1
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter filename: The name of the string file. The default value is "Localizable"
     */
    public func showLocalizedInput(withTitle title: String, withLocalizationFile filename: String = String.DefaultLocalizationFile) {
        let localizedTitle = title.localize(withLocalizationFile: filename)
        showInput(withTitle: localizedTitle)
    }
}
