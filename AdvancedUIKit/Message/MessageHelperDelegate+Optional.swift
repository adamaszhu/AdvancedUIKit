/**
 * MessageHelperDelegate+Optional is used to define the default behavior after performing an action about the message.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
public extension MessageHelperDelegate {
    
    /**
     * MessageHelperDelegate
     */
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) { }
    
    /**
     * MessageHelperDelegate
     */
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) { }
    
    /**
     * MessageHelperDelegate
     */
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) { }
    
    /**
     * MessageHelperDelegate
     */
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) { }
    
    /**
     * MessageHelperDelegate
     */
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) { }
    
}

import Foundation
