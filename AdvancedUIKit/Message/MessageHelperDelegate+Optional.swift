/// MessageHelperDelegate+Optional is used to define the default behavior after performing an action about the message.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
public extension MessageHelperDelegate {
    
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper) { }
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) { }
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper) { }
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) { }
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper) { }
    
}

import Foundation
