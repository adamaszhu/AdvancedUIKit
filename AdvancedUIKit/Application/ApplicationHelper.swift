#if !os(macOS)
/// Helper functions for accessing external applications
///
/// - author: Adamas
/// - date: 15/09/2019
/// - version: 1.5.0
public final class ApplicationHelper {
    
    /// The singletion
    public static let shared: ApplicationHelper = ApplicationHelper()
    
    /// The application
    private let application: UIApplication
    
    /// Check the installation status of a specific app.
    /// Need to add the scheme into `LSApplicationQueriesSchemes` array inside `info.plist` file
    ///
    /// - Parameter type: The application type
    /// - Returns: Whether or not the app is installed
    public func isApplicationInstalled(with type: ApplicationType) -> Bool {
        guard let url = URL(string: type.rawValue + Self.urlSchemeSeparator) else {
            Logger.standard.logError(Self.schemeError)
            return false
        }
        return application.canOpenURL(url)
    }
    
    /// Create the helper.
    ///
    /// - Parameter application: The actual application
    private init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
}

/// Constants
private extension ApplicationHelper {
    
    /// Separator
    static let urlSchemeSeparator = "://"
    
    /// System error.
    static let schemeError = "The scheme is invalid."
}

import AdvancedFoundation
import UIKit
#endif
