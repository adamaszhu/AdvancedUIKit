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
    private var defaultKeyboardPushDuration: Double {
        return 0.1
    }
    
    /**
 * System error.
 */
    private var keyboardInfoError: String {
        return "The information of the keyboard cannot be retrieved."
    }
    
    
    //
    //
    //
    //
    //    /**
    //     * Start observing the keyboard.
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func startObserving() {
    //        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard), name: UIKeyboardWillShowNotification, object: nil)
    //        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard), name: UIKeyboardWillHideNotification, object: nil)
    //        notificationCenter.addObserver(self, selector: #selector(willChangeKeyboardFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
    //    }
    //
    //    /**
    //     * Stop observing the keyboard.
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func stopObserving() {
    //        notificationCenter.removeObserver(self)
    //        currentInputView = nil
    //    }
    //
    //    /**
    //     * Dismiss the keyboard. It only happens when the view is forced to remove focus or the hide keyboard method has been called.
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     * - parameter notification: The notification of the keyboard action.
    //     */
    //    public func willHideKeyboard(withNotification notification: NSNotification) {
    //        keyboardActionView.hidden = true
    //        willChangeKeyboardFrame(withNotification: notification)
    //        adjustOffset()
    //    }
    //
    //    /**
    //     * Show the keyboard.
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     * - parameter notification: The notification of the keyboard action.
    //     */
    //    public func willShowKeyboard(withNotification notification: NSNotification) {
    //        keyboardActionView.hidden = false
    //        willChangeKeyboardFrame(withNotification: notification)
    //        adjustOffset()
    //    }
    //
    //    /**
    //     * The frame of the keyboard will be changed. Get the height of the keyboard and duration while waiting for the adjustion.
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     * - parameter notification: The notification of the keyboard action.
    //     */
    //    public func willChangeKeyboardFrame(withNotification notification: NSNotification) {
    //        refreshKeyboardHeight(withNotification: notification)
    //        refreshPushDuration(withNotification: notification)
    //    }
    //
    //
        /**
         * Get the offset of the push animation.
         * - parameter notification: The notification of the keyboard action.
         */
        private func refreshKeyboardHeight(withNotification notification: NSNotification) {
            guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                Logger.standard.logError(keyboardInfoError)
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
                Logger.standard.logError(keyboardInfoError)
                keyboardPushDuration = defaultKeyboardPushDuration
                return
            }
            keyboardPushDuration = value.doubleValue < defaultKeyboardPushDuration ? defaultKeyboardPushDuration : value.doubleValue
        }
    
}

import UIKit
