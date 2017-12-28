/// KeyboarHelper is used to optimize the soft keyboard performance.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
final public class KeyboardHelper: NSObject {
    
    /// The delegate
    public var keyboardHelperDelegate: KeyboardHelperDelegate?
    
    /// The root view.
    @objc public var rootView: UIView!
    
    /// A list of input views that need the help of KeyboardHelper.
    @objc public var inputViews: [UIView] {
        willSet {
            deactiveInputChain()
        }
        didSet {
            activateInputChain()
            currentInputView = nil
            actionFilterView.inputViews = inputViews
        }
    }
    
    /// The assistant view used to perform gesture action.
    @objc var actionFilterView: ActionFilterView
    
    /// Current input view, which will be used to decide whether the view should be pushed up or not. It should be set when the begin editing is called.
    @objc var currentInputView: UIView?
    
    /// The notification center.
    @objc var notificationCenter: NotificationCenter
    
    /// The height of current keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    @objc var keyboardHeight: CGFloat
    
    /// The duration of pushing the keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    @objc var keyboardPushDuration: TimeInterval
    
    /// Judge whether the view should be pushed or not according to the position of the text field.
    private var pushOffset: CGFloat {
        guard let currentInputView = currentInputView else {
            // The keyboard is going to be hide.
            return 0
        }
        let currentViewFrame = rootView.convert(currentInputView.frame, from: currentInputView.superview)
        let currentViewBottomSpace = rootView.frame.height - currentViewFrame.origin.y - currentViewFrame.size.height
        guard currentViewBottomSpace < keyboardHeight else {
            return 0
        }
        // 30 is the gap between current view and the keyboard after the view being pushed up.
        return currentViewBottomSpace - keyboardHeight// - 30
    }
    
    /// Initialize the object. It should be initalized after the view is rendered.
    ///
    /// - Parameter application: The application that contains the window.
    @objc public init(application: UIApplication = UIApplication.shared, notificationCenter: NotificationCenter = NotificationCenter.default) {
        inputViews = []
        actionFilterView = ActionFilterView(frame: application.windows[0].bounds)
        self.notificationCenter = notificationCenter
        keyboardHeight = 0
        keyboardPushDuration = 0
        super.init()
        actionFilterView.actionFilterViewDelegate = self
    }
    
    /// Hide the keyboard.
    @objc public func hideKeyboard() {
        currentInputView?.resignFirstResponder()
        currentInputView?.endEditing(true)
        currentInputView = nil
        // No text field has been selected.
        rootView.resignFirstResponder()
        rootView.endEditing(true)
    }
    
    /// Change input view.
    ///
    /// - Parameter view: The new view.
    @objc func changeInputView(_ view: UIView) {
        // If previous input view is not nil, then the keyboard is shown. As a result, the view should adjusted.
        let shouldAdjustOffset = currentInputView != nil
        currentInputView = view
        if let _ = actionFilterView.superview, shouldAdjustOffset {
            // The keyboard push has been activated. So wait to see if the frame of the keyboard will be changed or not.
            // Make this specify to iOS 8 and below, since willShowKeyboard won't be called if the keyboard keeps the same in iOS 8 and below.
            perform(#selector(adjustOffset), with: nil, afterDelay: 0.2)
        }
    }
    
    /// Finished inputing on an input view.
    ///
    /// - Parameter view: The view that has finished inputing action.
    @objc func finishInput(onView view: UIView) {
        guard let index = inputViews.index(of: view) else {
            Logger.standard.log(error: KeyboardHelper.inputViewError)
            return
        }
        guard index < inputViews.count - 1 else {
            hideKeyboard()
            keyboardHelperDelegate?.keyboardHelperDidConfirmInput(self)
            return
        }
        inputViews[index + 1].becomeFirstResponder()
    }
    
    /// adjust the offset of the view.
    @objc func adjustOffset() {
        rootView.animate(withChange: { [unowned self] in
            self.rootView.frame.origin = CGPoint(x: 0, y: self.rootView.frame.origin.y + self.pushOffset)
            }, withDuration: keyboardPushDuration)
    }
    
    /// Activate monitoring the input chain.
    private func activateInputChain() {
        inputViews.forEach {
            if let textField = $0 as? UITextField {
                textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
                textField.delegate = self
            } else if let searchBar = $0 as? UISearchBar {
                searchBar.delegate = self
            }
        }
    }
    
    /// Stop monitoring the input chain.
    private func deactiveInputChain() {
        inputViews.forEach {
            if let textField = $0 as? UITextField {
                textField.removeTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
            }
        }
    }
    
}

import UIKit
