final class NotificationViewController: UIViewController {
    
    private var messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    private lazy var notificationHelper: NotificationHelper = {
        let notificationHelper = NotificationHelper()
        notificationHelper.delegate = self
        return notificationHelper
    }()
    
    @IBAction func requestNotificationAuthorization(_ sender: Any) {
        notificationHelper.requestLocalNotificationPermission()
    }
    
    @IBAction func showLocalNotification(_ sender: Any) {
        showLocalNotification()
    }
    
    private func showLocalNotification() {
        notificationHelper.createLocalNotification(withTitle: Self.notificationTitle, content: Self.notificationContent, andDelay: Self.notificationDelay)
    }
}

extension NotificationViewController: NotificationHelperDelegate {
    
    func notificationHelper(_ notificationHelper: NotificationHelperType, didAuthorizeRemoteNotification result: Bool) {}
    
    func notificationHelper(_ notificationHelper: NotificationHelperType, didAuthorizeLocalNotification result: Bool) {
        messageHelper?.showInfo("\(result)")
    }
    
    func notificationHelper(_ notificationHelper: NotificationHelperType, didCatchError error: String) {
        messageHelper?.showError(error)
    }
}

private extension NotificationViewController {
    static let notificationTitle = "Title"
    static let notificationContent = "Content"
    static let notificationDelay = 5.0
}

import AdvancedUIKit
import UIKit

