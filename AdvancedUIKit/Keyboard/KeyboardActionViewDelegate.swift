import Foundation

/**
 * KeyboardActionViewDelegate is used to notify that an action has been performed on the view.
 * - version: 0.0.1
 * - date: 16/10/2016
 * - author: Adamas
 */
protocol KeyboardActionViewDelegate {
    
    /**
     * An action has been caught.
     * - version: 0.0.1
     * - date: 16/10/2016
     */
    func keyboardActionViewDidInteract(keyboardActionView: KeyboardActionView)
    
}
