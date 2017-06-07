/**
 * KeyboardHelper+ActionFilterViewDelegate defines the action to be done if the filter view capture an action.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2017
 */
extension KeyboardHelper: ActionFilterViewDelegate {
    
    /**
     * ActionFilterViewDelegate
     */
    func actionFilterViewDidInteract(_ actionFilterView: ActionFilterView) {
        hideKeyboard()
    }
    
}

import Foundation
