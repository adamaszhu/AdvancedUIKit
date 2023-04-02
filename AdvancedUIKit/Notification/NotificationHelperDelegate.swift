#if !os(macOS) && !targetEnvironment(macCatalyst)
/// NotificationHelperDelegate is used to get the result of an authorization.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 03/09/2019
public protocol NotificationHelperDelegate: AnyObject {
    
    /// Local notification authorization has been decided.
    ///
    /// - Parameter result: The result of the authorization.
    func notificationHelper(_ notificationHelper: NotificationHelperType,
                            didAuthorizeRemoteNotification result: Bool)
    
    /// Local notification authorization has been decided.
    ///
    /// - Parameter result: The result of the authorization.
    func notificationHelper(_ notificationHelper: NotificationHelperType,
                            didAuthorizeLocalNotification result: Bool)

    /// The notification is not authorized.
    ///
    /// - Parameter error: The error message.
    func notificationHelper(_ notificationHelper: NotificationHelperType,
                            didCatchError error: String)
}

import UIKit
#endif
