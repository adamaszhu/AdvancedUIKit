/// MessageHelper defines constants used by a message helper
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
extension MessageHelper {
    
    /// Default message title.
    public static var successTitle: String { return "" }
    public static var warningTitle: String { return "Warning".localizedInternalString(forType: MessageHelper.self) }
    public static var errorTitle: String { return "Error".localizedInternalString(forType: MessageHelper.self) }
    
    /// The name of the button.
    public static var infoConfirmButtonName: String { return "Ok".localizedInternalString(forType: MessageHelper.self) }
    public static var warningConfirmButtonName: String { return "Yes".localizedInternalString(forType: MessageHelper.self) }
    public static var warningCancelButtonName: String { return "No".localizedInternalString(forType: MessageHelper.self) }
    public static var errorConfirmButtonName: String { return "Ok".localizedInternalString(forType: MessageHelper.self) }
    public static var inputConfirmButtonName: String { return "Done".localizedInternalString(forType: MessageHelper.self) }
    public static var inputCancelButtonName: String { return "Cancel".localizedInternalString(forType: MessageHelper.self) }
    
    /// Input hint.
    static var inputHint: String { return "InputHint".localizedInternalString(forType: MessageHelper.self) }
    
}
