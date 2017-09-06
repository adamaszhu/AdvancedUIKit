/// KeyboarHelper is used to optimize the soft keyboard performance.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
public class KeyboardHelper: NSObject {
    
    /// System message.
    private static let inputViewError = "The input view doesn't exist."
    
    /// The delegate
    public var keyboardHelperDelegate: KeyboardHelperDelegate?
    
    /// The root view.
    public var rootView: UIView!
    
    /// A list of input views that need the help of KeyboardHelper.
    public var inputViews: [UIView] {
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
    var actionFilterView: ActionFilterView
    
    /// Current input view, which will be used to decide whether the view should be pushed up or not. It should be set when the begin editing is called.
    var currentInputView: UIView?
    
    /// The notification center.
    var notificationCenter: NotificationCenter
    
    /// The height of current keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    var keyboardHeight: CGFloat
    
    /// The duration of pushing the keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    var keyboardPushDuration: TimeInterval
    
    /// Judge whether the view should be pushed or not according to the position of the text field.
    private var pushOffset: CGFloat {
        guard let currentInputView = currentInputView else {
            // COMMENT: The keyboard is going to be hide.
            return 0
        }
        let currentViewFrame = rootView.convert(currentInputView.frame, from: currentInputView.superview)
        let currentViewBottomSpace = rootView.frame.height - currentViewFrame.origin.y - currentViewFrame.size.height
        if currentViewBottomSpace < keyboardHeight {
            // COMMENT: 30 is the gap between current view and the keyboard after the view being pushed up.
            return currentViewBottomSpace - keyboardHeight// - 30
        }
        return 0
    }
    
    /// Initialize the object. It should be initalized after the view is rendered.
    ///
    /// - Parameter application: The application that contains the window.
    public init(application: UIApplication = UIApplication.shared, notificationCenter: NotificationCenter = NotificationCenter.default) {
        inputViews = []
        actionFilterView = ActionFilterView(frame: application.windows[0].bounds)
        self.notificationCenter = notificationCenter
        keyboardHeight = 0
        keyboardPushDuration = 0
        super.init()
        actionFilterView.actionFilterViewDelegate = self
    }
    
    /// Hide the keyboard.
    public func hideKeyboard() {
        currentInputView = nil
        // COMMENT: No text field has been selected.
        rootView.resignFirstResponder()
        rootView.endEditing(true)
    }
    
    /// Change input view.
    ///
    /// - Parameter view: The new view.
    func changeInputView(_ view: UIView) {
        // COMMENT: If previous input view is not nil, then the keyboard is shown. As a result, the view should adjusted.
        let shouldAdjustOffset = currentInputView != nil
        currentInputView = view
        if actionFilterView.superview != nil {
            // COMMENT: The keyboard push has been activated. So wait to see if the frame of the keyboard will be changed or not.
            if shouldAdjustOffset {
                // COMMENT: Make this specify to iOS 8 and below, since willShowKeyboard won't be called if the keyboard keeps the same in iOS 8 and below.
                perform(#selector(adjustOffset), with: nil, afterDelay: 0.2)
            }
        }
    }
    
    /// Finished inputing on an input view.
    ///
    /// - Parameter view: The view that has finished inputing action.
    func finishInput(onView view: UIView) {
        guard let index = inputViews.index(of: view) else {
            Logger.standard.log(error: KeyboardHelper.inputViewError)
            return
        }
        if index < inputViews.count - 1 {
            inputViews[index + 1].becomeFirstResponder()
        } else {
            hideKeyboard()
            keyboardHelperDelegate?.keyboardHelperDidConfirmInput(self)
        }
    }
    
    /// adjust the offset of the view.
    func adjustOffset() {
        rootView.animate(withChange: { [unowned self] _ in
            self.rootView.frame.origin = CGPoint(x: 0, y: self.pushOffset)
            }, withDuration: keyboardPushDuration)
    }
    
    /// Activate monitoring the input chain.
    private func activateInputChain() {
        // TODO: Consider other types of views.
        for view in inputViews {
            if let textField = view as? UITextField {
                textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
                // TODO: Use target instead of using delegate.
                textField.delegate = self
            } else if let searchBar = view as? UISearchBar {
                // TODO: Use target instead of using delegate.
                searchBar.delegate = self
            }
        }
    }
    
    /// Stop monitoring the input chain.
    private func deactiveInputChain() {
        for view in inputViews {
            if let textField = view as? UITextField {
                textField.removeTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
            }
        }
    }
    
}

import UIKit
