#if !os(macOS)
/// KeyboarHelper is used to optimize the soft keyboard performance.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 16/08/2019
public final class KeyboardHelper: NSObject {
    
    /// The delegate
    public weak var delegate: KeyboardHelperDelegate?
    
    /// The root view.
    public weak var rootView: UIView?
    
    /// A list of input views that need the help of KeyboardHelper.
    public var inputViews: [UIView] = [] {
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
    private var actionFilterView: ActionFilterView
    
    /// Current input view, which will be used to decide whether the view should be pushed up or not. It should be set when the begin editing is called.
    private var currentInputView: UIView?
    
    /// The notification center.
    private var notificationCenter: NotificationCenter
    
    /// The height of current keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    private var keyboardHeight: CGFloat = 0
    
    /// The duration of pushing the keyboard. It is used under the situation that the input view has been changed without the change of keyboard height.
    private var keyboardPushDuration: TimeInterval = 0
    
    /// Judge whether the view should be pushed or not according to the position of the text field.
    private var pushOffset: CGFloat {
        guard let currentInputView = currentInputView else {
            // The keyboard is going to be hide.
            return 0
        }
        guard let rootView = rootView else {
            Logger.standard.logWarning(Self.rootViewWarning)
            return 0
        }
        let currentViewFrame = rootView.convert(currentInputView.frame,
                                                from: currentInputView.superview)
        let currentViewBottomSpace = rootView.frame.height - currentViewFrame.origin.y - currentViewFrame.size.height
        guard currentViewBottomSpace < keyboardHeight else {
            return 0
        }
        return currentViewBottomSpace - keyboardHeight
    }
    
    /// Initialize the object. It should be initalized after the view is rendered.
    ///
    /// - Parameter application: The application that contains the window.
    public init(application: UIApplication = .shared,
                notificationCenter: NotificationCenter = .default) {
        actionFilterView = ActionFilterView(frame: application.windows[0].bounds)
        self.notificationCenter = notificationCenter
        super.init()
        actionFilterView.delegate = self
    }
    
    /// Hide the keyboard.
    public func hideKeyboard() {
        currentInputView?.resignFirstResponder()
        currentInputView?.endEditing(true)
        currentInputView = nil
        // No text field has been selected.
        rootView?.resignFirstResponder()
        rootView?.endEditing(true)
    }
    
    /// Start observing the keyboard.
    public func startObservingKeyboard() {
        rootView?.addSubview(actionFilterView)
        actionFilterView.isHidden = true
        notificationCenter.addObserver(self,
                                       selector: #selector(willShowKeyboard),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(willHideKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(willChangeKeyboardFrame),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
    }
    
    /// Stop observing the keyboard and perform the push action.
    public func stopObservingKeyboard() {
        notificationCenter.removeObserver(self)
        currentInputView = nil
        actionFilterView.removeFromSuperview()
    }
    
    /// adjust the offset of the view.
    @objc func adjustOffset() {
        guard let rootView = rootView else {
            Logger.standard.logWarning(Self.rootViewWarning)
            return
        }
        rootView.animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            rootView.frame.origin = CGPoint(x: 0,
                                            y: rootView.frame.origin.y + self.pushOffset)
            }, withDuration: keyboardPushDuration)
    }
    
    /// Dismiss the keyboard. It only happens when the view is forced to remove focus or the hide keyboard method has been called.
    ///
    /// - Parameter notification: The notification of the keyboard action.
    @objc func willHideKeyboard(with notification: NSNotification) {
        actionFilterView.isHidden = true
        willChangeKeyboardFrame(with: notification)
        adjustOffset()
    }
    
    /// Show the keyboard.
    ///
    /// - Parameter notification: The notification of the keyboard action.
    @objc func willShowKeyboard(with notification: NSNotification) {
        actionFilterView.isHidden = false
        willChangeKeyboardFrame(with: notification)
        adjustOffset()
    }
    
    /// The frame of the keyboard will be changed. Get the height of the keyboard and duration while waiting for the adjustion.
    ///
    /// - Parameter notification: The notification of the keyboard action.
    @objc func willChangeKeyboardFrame(with notification: NSNotification) {
        refreshKeyboardHeight(with: notification)
        refreshPushDuration(with: notification)
    }
    
    /// Change input view.
    ///
    /// - Parameter view: The new view.
    private func changeInputView(_ view: UIView) {
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
    private func finishInput(on view: UIView) {
        guard let index = inputViews.firstIndex(of: view) else {
            Logger.standard.logError(Self.inputViewError)
            return
        }
        guard index < inputViews.count - 1 else {
            hideKeyboard()
            delegate?.keyboardHelperDidConfirmInput(self)
            return
        }
        inputViews[index + 1].becomeFirstResponder()
    }
    
    /// Activate monitoring the input chain.
    private func activateInputChain() {
        inputViews.forEach {
            if let textField = $0 as? UITextField {
                textField.addTarget(self, action: #selector(textFieldDidChangeText),
                                    for: .editingChanged)
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
                textField.removeTarget(self, action: #selector(textFieldDidChangeText),
                                       for: .editingChanged)
            }
        }
    }
    
    /// Get the offset of the push animation.
    ///
    /// - Parameter notification: The notification of the keyboard action.
    private func refreshKeyboardHeight(with notification: NSNotification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            Logger.standard.logError(Self.keyboardInfoError)
            keyboardHeight = 0
            return
        }
        keyboardHeight = value.cgRectValue.height
    }
    
    /// Refresh the duration of the animation.
    ///
    /// - Parameter notification: The notification of the keyboard action.
    private func refreshPushDuration(with notification: NSNotification) {
        guard let value = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            Logger.standard.logError(Self.keyboardInfoError)
            keyboardPushDuration = Self.defaultKeyboardPushDuration
            return
        }
        keyboardPushDuration = value.doubleValue < Self.defaultKeyboardPushDuration
        ? Self.defaultKeyboardPushDuration
        : value.doubleValue
    }
}

extension KeyboardHelper: UISearchBarDelegate {
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        changeInputView(searchBar)
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        finishInput(on: searchBar)
    }
    
    public func searchBar(_ searchBar: UISearchBar,
                          textDidChange searchText: String) {
        delegate?.keyboardHelper(self, didChangeContentOf: searchBar)
    }
    
    public func searchBar(_ searchBar: UISearchBar,
                          shouldChangeTextIn range: NSRange,
                          replacementText text: String) -> Bool {
        guard let delegate = delegate else {
            return true
        }
        var newContent: String
        if let originalText = searchBar.text as NSString? {
            newContent = originalText.replacingCharacters(in: range, with: text)
        } else {
            newContent = text
        }
        return delegate.keyboardHelper(self,
                                       shouldChangeContentOf: searchBar,
                                       toContent: newContent)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.keyboardHelper(self, willEditOn: searchBar)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.keyboardHelper(self, didEditOn: searchBar)
    }
    
}

/// UITextFieldDelegate
extension KeyboardHelper: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        changeInputView(textField)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishInput(on: textField)
        return false
    }
    
    @objc public func textFieldDidChangeText(textField: UITextField) {
        delegate?.keyboardHelper(self, didChangeContentOf: textField)
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let delegate = delegate else {
            return true
        }
        var newContent: String
        if let originalText = textField.text as NSString? {
            newContent = originalText.replacingCharacters(in: range, with: string)
        } else {
            newContent = string
        }
        return delegate.keyboardHelper(self, shouldChangeContentOf: textField, toContent: newContent)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.keyboardHelper(self, willEditOn: textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.keyboardHelper(self, didEditOn: textField)
    }
}

/// ActionFilterViewDelegate
extension KeyboardHelper: ActionFilterViewDelegate {
    
    func actionFilterViewDidInteract(_ actionFilterView: ActionFilterView) {
        hideKeyboard()
    }
}

/// Constants
private extension KeyboardHelper {
    
    /// System error.
    static let keyboardInfoError = "The information of the keyboard cannot be retrieved."
    static let inputViewError = "The input view doesn't exist."
    
    /// Warning.
    static let rootViewWarning = "The root view hasn't been injected."
    
    /// Default keyboard push duration for instant keyboard frame change.
    static let defaultKeyboardPushDuration = 0.1
}

import AdvancedFoundation
import UIKit
#endif
