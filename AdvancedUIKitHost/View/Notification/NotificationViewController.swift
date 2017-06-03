class NotificationViewController: UIViewController {
    
    private let notificationHelper: NotificationHelper
    
    private var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    required init?(coder aDecoder: NSCoder) {
        notificationHelper = NotificationHelper.shared
        super.init(coder: aDecoder)
        notificationHelper.notificationHelperDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationHelper.authorizeLocalNotification()
    }
    
    @IBAction func showLocalNotification(_ sender: Any) {
        backgroundTask = UIApplication.shared.beginBackgroundTask()
        showLocalNotification()
    }
    
    func showLocalNotification() {
        let dispatchTime = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [unowned self] _ in
            self.notificationHelper.createLocalNotification(withTitle: "Title", withContent: "Content")
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        }
    }
    
}

import AdvancedUIKit
import UIKit

