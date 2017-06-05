/**
 * ActionFilterView is used to intercept action outside the keyboard.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2017
 */
class ActionFilterView: UIView {
    
    /**
     * Error message.
     */
    private let initError = "Constructor init(coder) shouldn't be called."
    
    /**
     * The delegate.
     */
    var actionFilterViewDelegate: ActionFilterViewDelegate?
    
    /**
     * A list of input view which should drag holes on the touch mask view.
     */
    var inputViews: Array<UIView>
    
    /**
     * UIView
     */
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for inputView in inputViews {
            let inputViewFrame = convert(inputView.frame, from: inputView.superview)
            guard !inputViewFrame.contains(point) else {
                // COMMENT: Ignore the touch within an input component.
                return false
            }
        }
        actionFilterViewDelegate?.actionFilterViewDidInteract(self)
        return true
    }
    
    /**
     * UIView
     */
    override init(frame: CGRect) {
        inputViews = []
        super.init(frame: frame)
    }
    
    /**
     * UIView
     */
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(initError)
        return nil
    }
    
}

import UIKit
