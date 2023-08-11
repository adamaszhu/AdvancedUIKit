#if !os(macOS) && !targetEnvironment(macCatalyst)
/// NotificationHelperType is used to manage the notification.
///
/// - author: Adamas
/// - version: 1.9.15
/// - date: 29/03/2023
public protocol NotificationHelperType {

    /// Parse a token data into a string
    ///
    /// - Parameter data: The token data
    /// - Returns: The token string
    static func deviceToken(from data: Data) -> String
    
    /// The delegate.
    var delegate: NotificationHelperDelegate? { get set }
    
    /// Whether the remote notification is authorized or not.
    var isRemoteNotificationAuthorized: Bool { get }
    
    /// Check the local notification permission
    ///
    /// - Important:
    /// Since iOS 13, the callback won't be triggered in `applicationWillTerminate(_)`
    ///
    /// - Parameter completion: The callback
    func checkLocalNotificationPermission(completion: @escaping (Bool?) -> Void)
    
    /// Register the local notification function.
    func requestLocalNotificationPermission()
    
    /// Register the remote notification function.
    func requestRemoteNotificationPermission()
    
    /// Post a local notification.
    ///
    /// - Parameters:
    ///   - title: The title of the notification.
    ///   - content: The content of the notification.
    ///   - delay: Delay in second for showing the notification
    ///   - soundName: The name of the sound. Nil stands for the default sound.
    func createLocalNotification(withTitle title: String?,
                                 content: String,
                                 delay: Double,
                                 andSoundName soundName: String?)
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
                                andSoundName: nil)
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
                                andSoundName: nil)
    }
}

/// The helper used by ios 10 and later.
@available(iOS, introduced: 10.0)
public final class NotificationHelper: NotificationHelperType {

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
    public init(application: UIApplication = .shared,
                notificationCenter: UNUserNotificationCenter = .current()) {
        self.application = application
        self.notificationCenter = notificationCenter
    }

    public static func deviceToken(from data: Data) -> String {
        data.map{String(format: Self.deviceTokenPattern, $0)}.joined()
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
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                if let error = error {
                    self.delegate?.notificationHelper(self,
                                                      didCatchError: error.localizedDescription)
                } else {
                    self.delegate?.notificationHelper(self,
                                                      didAuthorizeLocalNotification: result)
                }
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

    public func createLocalNotification(withTitle title: String?,
                                        content: String, delay: Double,
                                        andSoundName soundName: String?) {
        let notificationContent = UNMutableNotificationContent()
        if let title = title {
            notificationContent.title = title
            notificationContent.body = content
        } else {
            notificationContent.title = content
        }
        if let soundName = soundName {
            let notificationSoundName = UNNotificationSoundName(rawValue: soundName)
            notificationContent.sound = UNNotificationSound(named: notificationSoundName)
        } else {
            notificationContent.sound = UNNotificationSound.default
        }
        let adjustedDelay = max(1, delay)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: adjustedDelay,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: content,
                                            content: notificationContent,
                                            trigger: trigger)
        notificationCenter.add(request) { [weak self] error in
            if let error = error, let self = self {
                self.delegate?.notificationHelper(self, didCatchError: error.localizedDescription)
            }
        }
    }
}

/// Constants
fileprivate extension NotificationHelperType {
    
    /// The system error.
    static var authorizationError: String { "AuthorizationError" }
    
    /// Constants
    static var deviceTokenPattern: String { "%02.2hhx" }
}

import AdvancedFoundation
import UIKit
import UserNotifications
#endif
