/// NotificationHelper is used to manage the notification.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 02/06/2017
final public class NotificationHelper {
    
    /// The singleton helper.
    public static let shared = NotificationHelper()
    
    /// Whether the local notification is authorized or not.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public var isLocalNotificationAuthorized: Bool {
        // TODO: Implement this using the NSNotification framework.
        guard let setting = application.currentUserNotificationSettings else {
            Logger.standard.log(error: NotificationHelper.settingError)
            return false
        }
        return setting.types.contains(.alert)
    }
    
    /// Whether the remote notification is authorized or not.
    public var isRemoteNotificationAuthorized: Bool {
        return application.isRegisteredForRemoteNotifications
    }
    
    /// The delegate.
    public var notificationHelperDelegate: NotificationHelperDelegate?
    
    /// The application object.
    private var application: UIApplication
    
    /// Post a local notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - content: The content of the notification.
    ///   - soundName: The name of the sound.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func createLocalNotification(withTitle title: String, withContent content: String, withSoundName soundName: String = UILocalNotificationDefaultSoundName) {
        // TODO: Implement this using the NSNotification framework.
        if !isLocalNotificationAuthorized {
            notificationHelperDelegate?.notificationHelper(self, didCatchError: NotificationHelper.authorizationError.localizedInternalString(forType: NotificationHelper.self))
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
    
    /// Register the local notification function.
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
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application that the notification belongs to.
    private init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    
}

import UIKit
import UserNotifications
