/**
 * GestureFilterView filters the gesture within the view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 27/05/2017
 */
class GestureFilterView: UIView {
    
    /**
     * System error.
     */
    private let gestureRecognizersEmptyError = "Gesture recognizers have not been added to the view yet."
    
    /**
     * Change the enable status of a specific gesture type.
     * - parameter type: The type of the gesture.
     * - parameter shouldEnable: Whether the gesture recognizer should be enabled or not.
     */
    func changeGestureRecognizerUsibility(ofType type: AnyClass, toUsibility shouldEnable: Bool) {
        guard let gestureRecognizers = gestureRecognizers else {
            Logger.standard.logError(gestureRecognizersEmptyError)
            return
        }
        for gestureRecognizer in gestureRecognizers {
            if gestureRecognizer.isKind(of: type) {
                gestureRecognizer.isEnabled = shouldEnable
            }
        }
    }
    
    /**
     * Do nothing for a gesture.
     */
    func ignoreAction() {
    }
    
    /**
     * UIView
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        // TODO: Support other gestures.
        let gestureRecognizers = [UISwipeGestureRecognizer(target: self, action: #selector(ignoreAction)),
                                  UITapGestureRecognizer(target: self, action: #selector(ignoreAction)),
                                  UIPanGestureRecognizer(target: self, action: #selector(ignoreAction))]
        for gestureRecognizer in gestureRecognizers {
            gestureRecognizer.isEnabled = false
            addGestureRecognizer(gestureRecognizer)
        }
    }
    
    /**
     * UIView
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

import UIKit
