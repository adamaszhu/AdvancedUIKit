/// DeviceHelperDelegate is used when a futher action need to be performed following a device related action.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 29/05/2017
public protocol DeviceHelperDelegate {
    
    /// An error has occured during an operation.
    ///
    /// - Parameter error: The description of the error.
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String)
    
    /// The email has been sent.
    ///
    /// - Parameter result: The execusion result.
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool)
    
}
