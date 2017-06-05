/**
 * ActionFilterViewDelegate is used to notify that an action has been performed on the view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 06/05/2017
 */
protocol ActionFilterViewDelegate {
    
    /**
     * An action has been caught.
     */
    func actionFilterViewDidInteract(_ actionFilterView: ActionFilterView)
    
}
