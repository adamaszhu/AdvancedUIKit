import Foundation

/**
 * MessageHelperDelegate is used when a futher action need to be performed after performing an action about the message.
 * - version: 0.0.5
 * - date: 18/10/2016
 * - author: Adamas
 */
@objc public protocol MessageHelperDelegate {
    
    /**
     * An operation has been done on an info.
     * - version: 0.0.5
     * - date: 18/10/2016
     */
    optional func messageHelperDidConfirmInfo(messageHelper: MessageHelper)
    
    /**
     * An operation has been done on an error.
     * - version: 0.0.5
     * - date: 18/10/2016
     */
    optional func messageHelperDidConfirmError(messageHelper: MessageHelper)
    
    /**
     * An operation has been done on a warning.
     * - version: 0.0.5
     * - date: 18/10/2016
     */
    optional func messageHelperDidConfirmWarning(messageHelper: MessageHelper)
    
    /**
     * An cancel has been done on a warning
     * - version: 0.0.5
     * - date: 18/10/2016
     */
    optional func messageHelperDidCancelWarning(messageHelper: MessageHelper)
    
    /**
     * An operation has been done on an input.
     * - version: 0.0.5
     * - date: 18/10/2016
     * - parameter content: The content of the input.
     */
    optional func messageHelper(messageHelper: MessageHelper, didConfirmInput content: String)
    
    /**
     * An cancel has been done on an input
     * - version: 0.0.5
     * - date: 18/10/2016
     */
    optional func messageHelperDidCancelInput(messageHelper: MessageHelper)
    
}
