import UIKit


/**
 * MessageHelper is used to display a message on the screen.
 * - version: 0.0.9
 * - date: 18/10/2016
 * - author: Adamas
 */
public class MessageHelper: NSObject {
    
    /**
     * Default message title.
     */
    static let SuccessTitle = "Success"
    static let WarningTitle = "Warning"
    static let ErrorTitle = "Error"
    
    /**
     * The name of the button.
     */
    private static let InfoConfirmButtonName = "Ok"
    private static let WarningConfirmButtonName = "Yes"
    private static let WarningCancelButtonName = "No"
    private static let ErrorConfirmButtonName = "Ok"
    private static let InputConfirmButtonName = "Done"
    private static let InputCancelButtonName = "Cancel"
    
    /**
     * Error message.
     */
    private static let ShowError = "It is impossible to show the message."
    
    /**
     * Get the shared instance of the MessageHelper. If the protocol will be implemented, please create a new object.
     */
    public static var defaultHelper: MessageHelper {
        /**
         * - version: 0.0.9
         * - date: 18/10/2016
         */
        get{
            if messageHelper == nil {
                messageHelper = MessageHelper()
            }
            messageHelper?.messageHelperDelegate = nil
            return messageHelper!
        }
    }
    
    /**
     * The delegate of the MessageHelper.
     */
    public var messageHelperDelegate: MessageHelperDelegate?
    
    /**
     * The singleton object.
     */
    private static var messageHelper: MessageHelper?
    
    /**
     * The type of current message.
     */
    private var messageType: MessageType
    
    /**
     * Current message.
     */
    private var alertController: UIAlertController?
    
    /**
     * Popup an information message.
     * - version: 0.0.9
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content.
     */
    public func showInfo(withTitle title: String = SuccessTitle, withContent content: String) {
        hidePreviousMessage()
        let localizedConfirmButtonName = MessageHelper.InfoConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
        messageType = MessageType.Info
        let localizedTitle = title == MessageHelper.SuccessTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
        createMessage(withTitle: localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
        showMessage()
    }
    
    /**
     * Popup a warning message.
     * - version: 0.0.9
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     */
    public func showWarning(withTitle title: String = WarningTitle, withContent content: String) {
        hidePreviousMessage()
        let localizedConfirmButtonName = MessageHelper.WarningConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
        var localizedCancelButtonName = MessageHelper.WarningCancelButtonName.localizeInBundle(forClass: self.classForCoder) as? String
        messageType = MessageType.Warning
        let localizedTitle = title == MessageHelper.WarningTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
        createMessage(withTitle: localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName)
        showMessage()
    }
    
    /**
     * Popup an error message.
     * - version: 0.0.9
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     * - parameter content: The content of the message.
     */
    public func showError(withTitle title: String = ErrorTitle, withContent content: String) {
        hidePreviousMessage()
        let localizedConfirmButtonName = MessageHelper.ErrorConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
        messageType = MessageType.Error
        let localizedTitle = title == MessageHelper.ErrorTitle ? title.localizeInBundle(forClass: self.classForCoder) : title
        createMessage(withTitle: localizedTitle, withContent: content, withConfirmButtonName: localizedConfirmButtonName)
        showMessage()
    }
    
    /**
     * Show an input box.
     * - version: 0.0.9
     * - date: 18/10/2016
     * - parameter title: The title of the message.
     */
    public func showInput(withTitle title: String) {
        hidePreviousMessage()
        messageType = MessageType.Input
        let localizedConfirmButtonName = MessageHelper.InputConfirmButtonName.localizeInBundle(forClass: self.classForCoder)
        var localizedCancelButtonName = MessageHelper.InputCancelButtonName.localizeInBundle(forClass: self.classForCoder) as? String
        // TODO: The input thing.
        createMessage(withTitle: title, withContent: nil, withConfirmButtonName: localizedConfirmButtonName, withCancelButtonName: localizedCancelButtonName)
        alertController!.addTextFieldWithConfigurationHandler(nil)
        showMessage()
    }
    
    /**
     * Create an alert controller including a message.
     * - version: 0.0.9
     * - date: 18/10/2016
     * - parameter title: The title.
     * - parameter content: The content of the message. Nil means that it is an input message.
     * - parameter confirmButtonName: The name of the confirm button. If this is nil, the confirm button will not be shown.
     * - parameter cancelButtonName: The name of the cancel button.
     */
    private func createMessage(withTitle title: String, withContent content: String?, withConfirmButtonName confirmButtonName: String, withCancelButtonName cancelButtonName: String? = nil) {
        alertController = UIAlertController(title: title, message: content, preferredStyle: UIAlertControllerStyle.Alert)
        if cancelButtonName != nil {
            let cancelAction = UIAlertAction(title: cancelButtonName!, style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                switch self.messageType {
                case .Info:
                    break;
                case .Warning:
                    self.messageHelperDelegate?.messageHelperDidCancelWarning?(self)
                case .Error:
                    break
                case .Input:
                    self.messageHelperDelegate?.messageHelperDidCancelInput?(self)
                case .Unknown:
                    break;
                }
            }
            alertController!.addAction(cancelAction)
        }
        let confirmAction = UIAlertAction(title: confirmButtonName, style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            switch self.messageType {
            case .Info:
                self.messageHelperDelegate?.messageHelperDidConfirmInfo?(self)
            case .Warning:
                self.messageHelperDelegate?.messageHelperDidConfirmWarning?(self)
            case .Error:
                self.messageHelperDelegate?.messageHelperDidConfirmError?(self)
            case .Input:
                self.messageHelperDelegate?.messageHelper?(self, didConfirmInput: self.alertController!.textFields![0].text!)
            case .Unknown:
                break;
            }
        })
        alertController!.addAction(confirmAction)
    }
    
    /**
     * Show the alert controller with the message.
     * - version: 0.0.9
     * - date: 18/10/2016
     */
    private func showMessage() {
        var rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        if rootViewController == nil {
            logError(MessageHelper.ShowError)
            return
        }
        if rootViewController!.isKindOfClass(UINavigationController) {
            let navigationController = rootViewController as! UINavigationController
            rootViewController = navigationController.viewControllers.last
        }
        rootViewController?.presentViewController(alertController!, animated: true, completion: nil)
    }
    
    /**
     * Hide previous message.
     * - version: 0.0.9
     * - date: 18/10/2016
     */
    private func hidePreviousMessage() {
        if messageType != MessageType.Unknown {
            messageType = MessageType.Unknown
            alertController?.navigationController?.popViewControllerAnimated(false)
            alertController = nil
        }
    }
    
    /**
     * - version: 0.0.9
     * - date: 18/10/2016
     */
    private override init() {
        messageType = MessageType.Unknown
        super.init()
    }
}
