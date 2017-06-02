/**
 * NotificationHelper is used to manage the notification.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 02/06/2017
 */
public class NotificationHelper {
    
    /**
     * All messages.
     */
    private let authorizationError = "AuthorizationError"
    
    /**
     * The system error.
     */
    private let notificationSettingError = "The notification setting cannot be retrieved."
    
    /**
     * The singleton helper.
     */
    public static var shared: NotificationHelper = NotificationHelper()
    
    /**
     * Whether the local notification is authorized or not.
     */
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public var isLocalNotificationAuthorized: Bool {
        // TODO: Implement this using the NSNotification framework.
        guard let setting = application.currentUserNotificationSettings else {
            Logger.standard.logError(notificationSettingError)
            return false
        }
        return setting.types.contains(.alert)
    }
    
    /**
     * Whether the remote notification is authorized or not.
     */
    public var isRemoteNotificationAuthorized: Bool {
        return application.isRegisteredForRemoteNotifications
    }
    
    /**
     * The delegate.
     */
    public var notificationHelperDelegate: NotificationHelperDelegate?
    
    /**
     * The application object.
     */
    private var application: UIApplication
    
    /**
     * Post a local notification.
     * - parameter title: The title of the notification.
     * - parameter content: The content of the notification.
     * - parameter soundName: The name of the sound.
     */
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func createLocalNotification(withTitle title: String, withContent content: String, withSoundName soundName: String = UILocalNotificationDefaultSoundName) {
        // TODO: Implement this using the NSNotification framework.
        if !isLocalNotificationAuthorized {
            notificationHelperDelegate?.notificationHelper(self, didCatchError: authorizationError.localizeWithinFramework(forType: NotificationHelper.self))
            return
        }
        let notification = UILocalNotification()
        notification.timeZone = NSTimeZone.default
        notification.fireDate = Date()
        if #available(iOS 8.2, *) {
            notification.alertTitle = title
        }
        notification.alertBody = content
        notification.soundName = soundName
        application.scheduleLocalNotification(notification)
    }
    
    /**
     * Register the local notification function.
     */
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func authorizeLocalNotification() {
        // TODO: Implement this using the NSNotification framework.
        guard !isLocalNotificationAuthorized else {
            return
        }
        let types = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound] as UIUserNotificationType
        let setting = UIUserNotificationSettings(types: types, categories: nil)
        application.registerUserNotificationSettings(setting)
        notificationHelperDelegate?.notificationHelper(self, didAuthorizeLocalNotification: isLocalNotificationAuthorized)
    }
    
    // TODO: Register remote notification
    
    /**
     * Initialize the object.
     * - parameter application: The application that the notification belongs to.
     */
    private init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    
}

import UIKit
import UserNotifications
