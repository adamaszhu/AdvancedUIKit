/**
 * MessageHelper defines constants used by a message helper
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
extension MessageHelper {
    
    /**
     * Default message title.
     */
    static var successTitle: String { return "" }
    static var warningTitle: String { return "Warning".localizeWithinFramework(forType: MessageHelper.self) }
    static var errorTitle: String { return "Error".localizeWithinFramework(forType: MessageHelper.self) }
    
    /**
     * The name of the button.
     */
    static var infoConfirmButtonName: String { return "Ok".localizeWithinFramework(forType: MessageHelper.self) }
    static var warningConfirmButtonName: String { return "Yes".localizeWithinFramework(forType: MessageHelper.self) }
    static var warningCancelButtonName: String { return "No".localizeWithinFramework(forType: MessageHelper.self) }
    static var errorConfirmButtonName: String { return "Ok".localizeWithinFramework(forType: MessageHelper.self) }
    static var inputConfirmButtonName: String { return "Done".localizeWithinFramework(forType: MessageHelper.self) }
    static var inputCancelButtonName: String { return "Cancel".localizeWithinFramework(forType: MessageHelper.self) }
    
    /**
     * Input hint.
     */
    static var inputHint: String { return "InputHint".localizeWithinFramework(forType: MessageHelper.self) }
    
}
