#if !os(macOS)
/// DeviceHelperDelegate is used when a futher action need to be performed following a device related action.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/08/2019
public protocol DeviceHelperDelegate: AnyObject {
    
    /// An error has occured during an operation.
    ///
    /// - Parameter error: The description of the error.
    func deviceHelper(_ deviceHelper: DeviceHelper, didCatchError error: String)
    
    /// The email has been sent.
    ///
    /// - Parameter result: The execusion result.
    func deviceHelper(_ deviceHelper: DeviceHelper, didSendEmail result: Bool)
}
#endif
