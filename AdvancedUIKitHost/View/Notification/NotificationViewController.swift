final class NotificationViewController: UIViewController {
    
    private let notification = (title: "Title", content: "Content")
    private let notificationDelay = 5.0
    
    private lazy var notificationHelper: NotificationHelper = {
        let notificationHelper = NotificationHelper.shared
        notificationHelper.notificationHelperDelegate = self
        return notificationHelper
    }()
    
    private var backgroundTask = UIBackgroundTaskInvalid
    
    @IBAction func requestNotificationAuthorization(_ sender: Any) {
        notificationHelper.authorizeLocalNotification()
    }
    
    @IBAction func showLocalNotification(_ sender: Any) {
        backgroundTask = UIApplication.shared.beginBackgroundTask()
        showLocalNotification()
    }
    
    func showLocalNotification() {
        let dispatchTime = DispatchTime.now() + notificationDelay
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [unowned self] _ in
            self.notificationHelper.createLocalNotification(withTitle: self.notification.title, withContent: self.notification.content)
            self.backgroundTask = UIBackgroundTaskInvalid
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
        }
    }
    
}

import AdvancedUIKit
import UIKit

