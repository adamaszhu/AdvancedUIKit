/// NotificationHelperType is used to manage the notification.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 03/09/2019
public protocol NotificationHelperType {
    
    /// The delegate.
    var delegate: NotificationHelperDelegate? { get set }
    
    /// Whether the remote notification is authorized or not.
    var isRemoteNotificationAuthorized: Bool { get }
    
    /// Check the local notification permission
    ///
    /// - Parameter completion: The callback
    func checkLocalNotificationPermission(completion: @escaping (Bool?) -> Void)
    
    /// Register the local notification function.
    func requestLocalNotificationPermission()
    
    /// Register the remote notification function.
    func requestRemoteNotificationPermission()
    
    /// Parse a token data into a string
    ///
    /// - Parameter data: The token data
    /// - Returns: The token string
    func deviceToken(from data: Data) -> String
    
    /// Post a local notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - content: The content of the notification.
    ///   - delay: Delay in second for showing the notification
    ///   - soundName: The name of the sound.
    func createLocalNotification(withTitle title: String?,
                                 content: String,
                                 delay: Double,
                                 andSoundName soundName: String)
}

public extension NotificationHelperType {
    
    /// Post a local notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - content: The content of the notification.
    func createLocalNotification(withTitle title: String?,
                                 andContent content: String) {
        createLocalNotification(withTitle: title,
                                content: content,
                                delay: 0,
                                andSoundName: UILocalNotificationDefaultSoundName)
    }
    
    /// Post a local notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - content: The content of the notification.
    func createLocalNotification(withTitle title: String?,
                                 content: String,
                                 andDelay delay: Double) {
        createLocalNotification(withTitle: title,
                                content: content,
                                delay: delay,
                                andSoundName: UILocalNotificationDefaultSoundName)
    }
}

/// The helper used by ios 10 and later.
@available(iOS, introduced: 10.0)
final public class NotificationHelper: NotificationHelperType {

    public weak var delegate: NotificationHelperDelegate?
    
    public var isRemoteNotificationAuthorized: Bool {
        application.isRegisteredForRemoteNotifications
    }
    
    /// The application object.
    private var application: UIApplication
    
    /// The new notification center
    private let notificationCenter: UNUserNotificationCenter
    
    /// Initialize the object.
    ///
    /// - Parameters:
    ///   - application: The application that the notification belongs to.
    ///   - notificationCenter: The notification center
    public init(application: UIApplication = UIApplication.shared,
                notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.application = application
        self.notificationCenter = notificationCenter
    }
    
    public func checkLocalNotificationPermission(completion: @escaping (Bool?) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    completion(nil)
                case .authorized:
                    completion(true)
                default:
                    completion(false)
                }
            }
        }
    }
    
    public func requestLocalNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] result, error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.delegate?.notificationHelper(self, didCatchError: error.localizedDescription)
            } else {
                self.delegate?.notificationHelper(self, didAuthorizeLocalNotification: result)
            }
        }
    }
    
    public func requestRemoteNotificationPermission() {
        guard !isRemoteNotificationAuthorized else {
            return
        }
        application.registerForRemoteNotifications()
        // Abandon the deletate callback for old devices.
        delegate?.notificationHelper(self, didAuthorizeRemoteNotification: true)
    }
    
    public func deviceToken(from data: Data) -> String {
        data.map{String(format: Self.deviceTokenPattern, $0)}.joined()
    }
    
    public func createLocalNotification(withTitle title: String?,
                                        content: String, delay: Double,
                                        andSoundName soundName: String) {
        checkLocalNotificationPermission { [weak self] result in
            guard let self = self else {
                return
            }
            guard result == true else {
                self.delegate?.notificationHelper(self, didCatchError: Self.authorizationError.localizedInternalString(forType: Self.self))
                return
            }
            let notificationContent = UNMutableNotificationContent()
            if let title = title {
                notificationContent.title = title
                notificationContent.body = content
            } else {
                notificationContent.title = content
            }
            let notificationSoundName = UNNotificationSoundName(rawValue: soundName)
            notificationContent.sound = UNNotificationSound(named: notificationSoundName)
            let adjustedDelay = max(1, delay)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: adjustedDelay, repeats: false)
            let request = UNNotificationRequest(identifier: content, content: notificationContent, trigger: trigger)
            self.notificationCenter.add(request) { [weak self] error in
                if let error = error, let self = self {
                    self.delegate?.notificationHelper(self, didCatchError: error.localizedDescription)
                }
            }
        }
    }
}

/// The helper used by ios 9 and before.
@available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use NotificationHelper instead")
final public class StaleNotificationHelper: NotificationHelperType {
    
    public weak var delegate: NotificationHelperDelegate?
    
    public var isRemoteNotificationAuthorized: Bool {
        application.isRegisteredForRemoteNotifications
    }
    
    /// The application object.
    private var application: UIApplication
    
    /// Initialize the object.
    ///
    /// - Parameter application: The application that the notification belongs to.
    public init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }
    
    public func checkLocalNotificationPermission(completion: @escaping (Bool?) -> Void) {
        guard let setting = application.currentUserNotificationSettings else {
            Logger.standard.logError(Self.settingError)
            return completion(false)
        }
        return completion(setting.types.contains(.alert))
    }
    
    public func requestLocalNotificationPermission() {
        checkLocalNotificationPermission { [weak self] result in
            guard let self = self, result != true else {
                return
            }
            let types = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound] as UIUserNotificationType
            let setting = UIUserNotificationSettings(types: types, categories: nil)
            self.application.registerUserNotificationSettings(setting)
            // Abandon the deletate callback for old devices.
            self.delegate?.notificationHelper(self, didAuthorizeLocalNotification: true)
        }
    }
    
    public func requestRemoteNotificationPermission() {
        guard !isRemoteNotificationAuthorized else {
            return
        }
        application.registerForRemoteNotifications()
        // Abandon the deletate callback for old devices.
        delegate?.notificationHelper(self, didAuthorizeRemoteNotification: true)
    }
    
    public func deviceToken(from data: Data) -> String {
        return data.map{String(format: Self.deviceTokenPattern, $0)}.joined()
    }
    
    public func createLocalNotification(withTitle title: String?, content: String, delay: Double, andSoundName soundName: String) {
        checkLocalNotificationPermission { [weak self] result in
            guard let self = self else {
                return
            }
            guard result == true else {
                self.delegate?.notificationHelper(self, didCatchError: Self.authorizationError.localizedInternalString(forType: Self.self))
                return
            }
            let notification = UILocalNotification()
            notification.timeZone = NSTimeZone.default
            notification.fireDate = Date().addingTimeInterval(delay)
            if let title = title {
                notification.alertTitle = title
            }
            notification.alertBody = content
            notification.soundName = soundName
            self.application.scheduleLocalNotification(notification)
        }
    }
}

/// Constants
fileprivate extension NotificationHelperType {
    
    /// The system error.
    static var settingError: String { return "The notification setting cannot be retrieved." }
    static var authorizationError: String { return "AuthorizationError" }
    
    /// Constants
    static var deviceTokenPattern: String { return "%02.2hhx" }
}

import AdvancedFoundation
import UIKit
import UserNotifications
