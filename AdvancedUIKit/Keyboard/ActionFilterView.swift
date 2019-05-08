/// ActionFilterView is used to intercept action outside the keyboard.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
final class ActionFilterView: UIView {
    
    /// The delegate.
    var actionFilterViewDelegate: ActionFilterViewDelegate?
    
    /// A list of input view which should drag holes on the touch mask view.
    @objc var inputViews: [UIView]
    
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
    
    override init(frame: CGRect) {
        inputViews = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(ActionFilterView.initError)
        return nil
    }
    
}

import UIKit
