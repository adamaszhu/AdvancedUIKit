extension DeviceViewController: DeviceHelperDelegate {
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String) {
        // TODO: Popup the error.
        print(error)
    }
    
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool) {
        // TODO: Popup the message.
        print("\(result)")
    }
    
}

import UIKit
import AdvancedUIKit
