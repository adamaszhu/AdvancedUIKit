class NotificationViewController: UIViewController {
    
    private let notificationHelper: NotificationHelper
    
    required init?(coder aDecoder: NSCoder) {
        notificationHelper = NotificationHelper.shared
        super.init(coder: aDecoder)
    }
    
    @IBAction func showLocalNotification(_ sender: Any) {
        notificationHelper.createLocalNotification(withTitle: "Title", withContent: "Content")
    }
    
}

import AdvancedUIKit
import UIKit

