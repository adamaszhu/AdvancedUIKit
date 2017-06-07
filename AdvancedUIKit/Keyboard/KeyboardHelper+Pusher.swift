/**
 * KeyboardHelper+Pusher pushes the view up if the keyboard overlaps the input view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 06/06/2017
 */
extension KeyboardHelper {
    
    /**
     * Default keyboard push duration for instant keyboard frame change.
     */
    private static let defaultKeyboardPushDuration = 0.1
    
    /**
     * System error.
     */
    private static let keyboardInfoError = "The information of the keyboard cannot be retrieved."
    
    /**
     * Start observing the keyboard.
     */
    public func startObservingKeyboard() {
        rootView.addSubview(actionFilterView)
        actionFilterView.isHidden = true
        // TODO: Judge whether the keyboard has already been shown or not.
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard), name: .UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willChangeKeyboardFrame), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    /**
     * Stop observing the keyboard and perform the push action.
     */
    public func stopObservingKeyboard() {
        notificationCenter.removeObserver(self)
        currentInputView = nil
        actionFilterView.removeFromSuperview()
    }
    
    /**
     * Dismiss the keyboard. It only happens when the view is forced to remove focus or the hide keyboard method has been called.
     * - parameter notification: The notification of the keyboard action.
     */
    public func willHideKeyboard(withNotification notification: NSNotification) {
        actionFilterView.isHidden = true
        willChangeKeyboardFrame(withNotification: notification)
        adjustOffset()
    }
    
    /**
     * Show the keyboard.
     * - parameter notification: The notification of the keyboard action.
     */
    func willShowKeyboard(withNotification notification: NSNotification) {
        actionFilterView.isHidden = false
        willChangeKeyboardFrame(withNotification: notification)
        adjustOffset()
    }
    
    /**
     * The frame of the keyboard will be changed. Get the height of the keyboard and duration while waiting for the adjustion.
     * - parameter notification: The notification of the keyboard action.
     */
    func willChangeKeyboardFrame(withNotification notification: NSNotification) {
        refreshKeyboardHeight(withNotification: notification)
        refreshPushDuration(withNotification: notification)
    }
    
    /**
     * Get the offset of the push animation.
     * - parameter notification: The notification of the keyboard action.
     */
    private func refreshKeyboardHeight(withNotification notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            Logger.standard.logError(KeyboardHelper.keyboardInfoError)
            keyboardHeight = 0
            return
        }
        keyboardHeight = value.cgRectValue.height
    }
    
    /**
     * Refresh the duration of the animation.
     * - parameter notification: The notification of the keyboard action.
     */
    private func refreshPushDuration(withNotification notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
            Logger.standard.logError(KeyboardHelper.keyboardInfoError)
            keyboardPushDuration = KeyboardHelper.defaultKeyboardPushDuration
            return
        }
        keyboardPushDuration = value.doubleValue < KeyboardHelper.defaultKeyboardPushDuration ? KeyboardHelper.defaultKeyboardPushDuration : value.doubleValue
    }
    
}

import UIKit
