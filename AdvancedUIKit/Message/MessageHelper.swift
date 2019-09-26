/// MessageHelper defines the action that a message helper should do.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/09/2019
public protocol MessageHelper {
    
    var delegate: MessageHelperDelegate? { get set }
    
    /// Popup an information message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content.
    ///   - confirmButtonName: The name of the confirm button.
    func showInfo(_ content: String, withTitle title: String, withConfirmButtonName confirmButtonName: String)
    
    /// Popup a warning message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content of the message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button.
    func showWarning(_ content: String, withTitle title: String, withConfirmButtonName confirmButtonName: String, withCancelButtonName cancelButtonName: String)
    
    /// Popup an error message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content of the message.
    ///   - confirmButtonName: The name of the confirm button.
    func showError(_ content: String, withTitle title: String, withConfirmButtonName confirmButtonName: String)
    
    /// Show an input box.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button.
    func showInput(withTitle title: String, withConfirmButtonName confirmButtonName: String, withCancelButtonName cancelButtonName: String)
}

/// Constants
public extension MessageHelper {
    
    /// Default message title.
    static var successTitle: String { return "" }
    static var warningTitle: String { return "Warning" }
    static var errorTitle: String { return "Error" }
    
    /// The name of the button.
    static var infoConfirmButtonName: String { return "Ok" }
    static var warningConfirmButtonName: String { return "Yes" }
    static var warningCancelButtonName: String { return "No" }
    static var errorConfirmButtonName: String { return "Ok" }
    static var inputConfirmButtonName: String { return "Done" }
    static var inputCancelButtonName: String { return "Cancel" }
    
    /// Input hint.
    static var inputHint: String { return "InputHint" }
}
