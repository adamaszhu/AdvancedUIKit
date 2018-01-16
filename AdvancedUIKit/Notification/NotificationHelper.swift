/// NotificationHelper is used to manage the notification.
///
/// - author: Adamas
/// - version: 1.1.1
/// - date: 17/01/2018
final public class NotificationHelper {
    
    /// The singleton helper.
    public static let shared = NotificationHelper()
    
    /// Whether the local notification is authorized or not.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public var isLocalNotificationAuthorized: Bool {
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
    ///   - delay: Delay in second for showing the notification
    ///   - soundName: The name of the sound.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func createLocalNotification(withTitle title: String? = nil, withContent content: String, withDelay delay: Double = 0, withSoundName soundName: String = UILocalNotificationDefaultSoundName) {
        if !isLocalNotificationAuthorized {
            notificationHelperDelegate?.notificationHelper(self, didCatchError: NotificationHelper.authorizationError.localizedInternalString(forType: NotificationHelper.self))
            return
        }
        let notification = UILocalNotification()
        notification.timeZone = NSTimeZone.default
        notification.fireDate = Date().addingTimeInterval(delay)
        if #available(iOS 8.2, *), let title = title {
            notification.alertTitle = title
        }
        notification.alertBody = content
        notification.soundName = soundName
        application.scheduleLocalNotification(notification)
    }
    
    /// Register the local notification function.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func authorizeLocalNotification() {
        guard !isLocalNotificationAuthorized else {
            return
        }
        let types = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound] as UIUserNotificationType
        let setting = UIUserNotificationSettings(types: types, categories: nil)
        application.registerUserNotificationSettings(setting)
        // TODO: Fix the call back
        // notificationHelperDelegate?.notificationHelper(self, didAuthorizeLocalNotification: isLocalNotificationAuthorized)
    }
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application that the notification belongs to.
    private init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    
}

import UIKit
import UserNotifications
