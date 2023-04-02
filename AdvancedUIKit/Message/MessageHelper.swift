/// MessageHelper defines the action that a message helper should do.
///
/// - author: Adamas
/// - version: 1.9.15
/// - date: 29/03/2023
public protocol MessageHelper {
    
    var delegate: MessageHelperDelegate? { get set }
    
    /// Popup an information message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content.
    ///   - confirmButtonName: The name of the confirm button.
    func showInfo(_ content: String,
                  withTitle title: String,
                  withConfirmButtonName confirmButtonName: String)
    
    /// Popup a warning message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content of the message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button.
    func showWarning(_ content: String,
                     withTitle title: String,
                     withConfirmButtonName confirmButtonName: String,
                     withCancelButtonName cancelButtonName: String)
    
    /// Popup an error message.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - content: The content of the message.
    ///   - confirmButtonName: The name of the confirm button.
    func showError(_ content: String,
                   withTitle title: String,
                   withConfirmButtonName confirmButtonName: String)
    
    /// Show an input box.
    ///
    /// - Parameters:
    ///   - title: The title of the message.
    ///   - confirmButtonName: The name of the confirm button.
    ///   - cancelButtonName: The name of the cancel button.
    func showInput(withTitle title: String,
                   withConfirmButtonName confirmButtonName: String,
                   withCancelButtonName cancelButtonName: String)
}

/// Constants
public extension MessageHelper {
    
    /// Default message title.
    static var successTitle: String { "" }
    static var warningTitle: String { "Warning" }
    static var errorTitle: String { "Error" }
    
    /// The name of the button.
    static var infoConfirmButtonName: String { "Ok" }
    static var warningConfirmButtonName: String { "Yes" }
    static var warningCancelButtonName: String { "No" }
    static var errorConfirmButtonName: String { "Ok" }
    static var inputConfirmButtonName: String { "Done" }
    static var inputCancelButtonName: String { "Cancel" }
    
    /// Input hint.
    static var inputHint: String { "InputHint" }
}
