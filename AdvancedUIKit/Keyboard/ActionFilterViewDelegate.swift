#if !os(macOS)
/// ActionFilterViewDelegate is used to notify that an action has been performed on the view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
protocol ActionFilterViewDelegate: AnyObject {
    
    /// An action has been caught.
    func actionFilterViewDidInteract(_ actionFilterView: ActionFilterView)
}
#endif
