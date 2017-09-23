/// MessageHelper defines the action that a message helper should do.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
public protocol MessageHelper {
    
    var messageHelperDelegate: MessageHelperDelegate? { get set }
    
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
