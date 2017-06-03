class NotificationViewController: UIViewController {
    
    private let notificationHelper: NotificationHelper
    
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
        let dispatchTime = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [unowned self] _ in
            self.notificationHelper.createLocalNotification(withTitle: "Title", withContent: "Content")
        }
    }
    
}

import AdvancedUIKit
import UIKit

