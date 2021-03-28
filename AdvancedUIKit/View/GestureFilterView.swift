/// GestureFilterView filters the gesture within the view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 05/08/2019
final class GestureFilterView: UIView {
    
    /// Change the enable status of a specific gesture type.
    ///
    /// - Parameters:
    ///   - type: The type of the gesture.
    ///   - shouldEnable: Whether the gesture recognizer should be enabled or not.
    func changeGestureRecognizerUsibility(ofType type: AnyClass,
                                          toUsibility shouldEnable: Bool) {
        guard let gestureRecognizers = gestureRecognizers else {
            Logger.standard.logError(Self.gestureRecognizersError)
            return
        }
        gestureRecognizers.filter { $0.isKind(of: type) }
            .forEach { $0.isEnabled = shouldEnable }
    }
    
    /// Do nothing for a gesture.
    @objc func ignoreAction() {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        let gestureRecognizers = [
            UISwipeGestureRecognizer(target: self, action: #selector(ignoreAction)),
            UITapGestureRecognizer(target: self, action: #selector(ignoreAction)),
            UIPanGestureRecognizer(target: self, action: #selector(ignoreAction))]
        gestureRecognizers.forEach {
            $0.isEnabled = false
            addGestureRecognizer($0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(Self.initError)
        return nil
    }
}

/// Constants
private extension GestureFilterView {
    
    /// System error.
    static let gestureRecognizersError = "Gesture recognizers have not been added to the view yet."
    static let initError = "Constructor init(coder) shouldn't be called."
}

import AdvancedFoundation
import UIKit
