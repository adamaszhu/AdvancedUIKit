/**
 * NotificationHelperDelegate is used to get the result of an authorization.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public protocol NotificationHelperDelegate {
    
    /**
     * Local notification authorization has been decided.
     * - parameter result: The result of the authorization.
     */
    func notificationHelper(_ notificationHelper: NotificationHelper, didAuthorizeRemoteNotification result: Bool)

    /**
     * Local notification authorization has been decided.
     * - parameter result: The result of the authorization.
     */
    func notificationHelper(_ notificationHelper: NotificationHelper, didAuthorizeLocalNotification result: Bool)

    /**
     * The notification is not authorized.
     * - parameter error: The error message.
     */
    func notificationHelper(_ notificationHelper: NotificationHelper, didCatchError error: String)
    
}

import UIKit
