final class NotificationViewController: UIViewController {
    
    let notification = (title: "Title", content: "Content")
    let notificationDelay = 5.0
    
    var backgroundTask = UIBackgroundTaskInvalid
    
    lazy var notificationHelper: NotificationHelper = {
        let notificationHelper = NotificationHelper.shared
        notificationHelper.notificationHelperDelegate = self
        return notificationHelper
    }()
    
    @IBAction func requestNotificationAuthorization(_ sender: Any) {
        notificationHelper.authorizeLocalNotification()
    }
    
    @IBAction func showLocalNotification(_ sender: Any) {
        backgroundTask = UIApplication.shared.beginBackgroundTask()
        showLocalNotification()
    }
    
    private func showLocalNotification() {
        let dispatchTime = DispatchTime.now() + notificationDelay
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [unowned self] in
            self.notificationHelper.createLocalNotification(withTitle: self.notification.title, withContent: self.notification.content)
            self.backgroundTask = UIBackgroundTaskInvalid
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
        }
    }
    
}

import AdvancedUIKit
import UIKit

