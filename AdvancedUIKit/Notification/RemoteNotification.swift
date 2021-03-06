/// RemoteNotification records the information about a notification.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/05/2019
public struct RemoteNotification {
    
    /// The title of the notification.
    public let title: String?
    
    /// The content attached to the notification.
    public let body: String?
    
    /// Initialize the notification
    ///
    /// - Parameter userInfo: The payload received along with a notification
    public init?(userInfo: [AnyHashable : Any]) {
        guard let userInfo = userInfo as? NotificationDictionary,
            let aps = userInfo[Self.apsKey] as? NotificationDictionary else {
                Logger.standard.logError(Self.userInfoError)
                return nil
        }
        if let alert = aps[Self.alertKey] as? String {
            title = alert
            body = nil
            return
        }
        guard let alert = aps[Self.alertKey] as? NotificationDictionary else {
            Logger.standard.logError(Self.userInfoError)
            return nil
        }
        body = alert[Self.bodyKey] as? String
        title = alert[Self.titleKey] as? String
    }
}

/// Constants
private extension RemoteNotification {
    
    /// Alias
    typealias NotificationDictionary = [String: Any]
    
    /// Keys
    static let apsKey = "aps"
    static let alertKey = "alert"
    static let bodyKey = "body"
    static let titleKey = "title"
    
    /// System errors.
    static let userInfoError = "The user info received is invalid."
}

import AdvancedFoundation
