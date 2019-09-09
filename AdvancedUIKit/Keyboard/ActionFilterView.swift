/// ActionFilterView is used to intercept action outside the keyboard.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 15/08/2019
final class ActionFilterView: UIView {
    
    /// The delegate.
    weak var actionFilterViewDelegate: ActionFilterViewDelegate?
    
    /// A list of input view which should drag holes on the touch mask view.
    var inputViews: [UIView] = []
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for inputView in inputViews {
            let inputViewFrame = convert(inputView.frame, from: inputView.superview)
            guard !inputViewFrame.contains(point) else {
                // Ignore the touch within an input component.
                return false
            }
        }
        actionFilterViewDelegate?.actionFilterViewDidInteract(self)
        return true
    }
}

import AdvancedFoundation
import UIKit
