/// GestureFilterView filters the gesture within the view.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 27/05/2017
final class GestureFilterView: UIView {
    
    /// Change the enable status of a specific gesture type.
    ///
    /// - Parameters:
    ///   - type: The type of the gesture.
    ///   - shouldEnable: Whether the gesture recognizer should be enabled or not.
    func changeGestureRecognizerUsibility(ofType type: AnyClass, toUsibility shouldEnable: Bool) {
        guard let gestureRecognizers = gestureRecognizers else {
            Logger.standard.log(error: GestureFilterView.gestureRecognizersError)
            return
        }
        gestureRecognizers.forEach {
            if $0.isKind(of: type) {
                $0.isEnabled = shouldEnable
            }
        }
    }
    
    /// Do nothing for a gesture.
    func ignoreAction() {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let gestureRecognizers = [UISwipeGestureRecognizer(target: self, action: #selector(ignoreAction)),
                                  UITapGestureRecognizer(target: self, action: #selector(ignoreAction)),
                                  UIPanGestureRecognizer(target: self, action: #selector(ignoreAction))]
        gestureRecognizers.forEach {
            $0.isEnabled = false
            addGestureRecognizer($0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.log(error: GestureFilterView.initError)
        return nil
    }
    
}

import UIKit
