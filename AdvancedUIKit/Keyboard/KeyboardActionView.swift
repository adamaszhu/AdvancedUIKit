import UIKit

/**
 * KeyboardActionView is used to intercept action outside the keyboard.
 * - version: 0.0.2
 * - date: 16/10/2016
 * - author: Adamas
 */
class KeyboardActionView: UIView {
    
    /**
     * The delegate.
     */
    var keyboardActionViewDelegate: KeyboardActionViewDelegate?
    
    /**
     * A list of input view which should drag holes on the touch mask view.
     */
    var inputViewList: Array<UIView>
    
    /**
     * - version: 0.0.2
     * - date: 16/10/2016
     */
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for inputView in inputViewList {
            let inputViewFrame = convertRect(inputView.frame, fromView: inputView.superview)
            if inputViewFrame.contains(point) {
                // COMMENT: Ignore the touch within a component.
                return false
            }
        }
        keyboardActionViewDelegate?.keyboardActionViewDidInteract(self)
        return false
    }
    
    /**
     * - version: 0.0.2
     * - date: 16/10/2016
     */
    override init(frame: CGRect) {
        inputViewList = []
        super.init(frame: frame)
    }
    
    /**
     * - version: 0.0.2
     * - date: 16/10/2016
     */
    required init?(coder aDecoder: NSCoder) {
        inputViewList = []
        super.init(coder: aDecoder)
    }
    
}
