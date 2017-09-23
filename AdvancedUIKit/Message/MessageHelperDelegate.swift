/// MessageHelperDelegate is used when a futher action need to be performed after performing an action about the message.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
public protocol MessageHelperDelegate {
    
    /// An operation has been done on an error.
    func messageHelperDidConfirmError(_ messageHelper: MessageHelper)
    
    /// An operation has been done on a warning.
    func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper)
    
    /// An cancel has been done on a warning
    func messageHelperDidCancelWarning(_ messageHelper: MessageHelper)
    
    /// An operation has been done on an input.
    ///
    /// - Parameter content: The content of the input.
    func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String)
    
    /// An cancel has been done on an input
    func messageHelperDidCancelInput(_ messageHelper: MessageHelper)
    
}

import Foundation
