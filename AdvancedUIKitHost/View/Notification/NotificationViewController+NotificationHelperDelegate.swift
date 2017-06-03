extension NotificationViewController: NotificationHelperDelegate {
    
    func notificationHelper(_ notificationHelper: NotificationHelper, didCatchError error: String) {
        SystemMessageHelper.standard?.showError(error)
    }
    
}

import AdvancedUIKit
import UIKit
