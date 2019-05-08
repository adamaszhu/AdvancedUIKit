/// AppStoreHelper provides support for rating the app.
///
/// - author: Adamas
/// - version: 1.2.0
/// - date: 26/01/2018
public final class AppStoreHelper {
    
    /// The app store id
    private let id: String
    
    /// The flag used to record the review counter.
    private let reviewCounterFlag: String
    
    /// The message helper
    private let messageHelper: SystemMessageHelper?
    
    /// The user default used to save the counter.
    private let userDefaults: UserDefaults
    
    /// Initialize the helper
    ///
    /// - Parameter
    ///   - id: The app store id.
    ///   - reviewCounterFlag: The flag used to record the review counter.
    public init(id: String, reviewCounterFlag: String) {
        self.id = id
        self.reviewCounterFlag = reviewCounterFlag
        userDefaults = UserDefaults.standard
        messageHelper = SystemMessageHelper()
        messageHelper?.messageHelperDelegate = self
    }
    
    /// Leave a review in the app store.
    public func review() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            return
        }
        guard let messageHelper = messageHelper else {
            Logger.standard.logError(AppStoreHelper.messageHelperError)
            return
        }
        let message = AppStoreHelper.reviewMessage.localizedInternalString(forType: AppStoreHelper.self)
        let confirmButtonTitle = AppStoreHelper.confirmButtonName.localizedInternalString(forType: AppStoreHelper.self)
        let cancelButtonTitle = AppStoreHelper.cancelButtonName.localizedInternalString(forType: AppStoreHelper.self)
        messageHelper.showWarning(message, withTitle: .empty, withConfirmButtonName: confirmButtonTitle, withCancelButtonName: cancelButtonTitle)
    }
    
    /// The feature counter is used for
    public func increaseReviewCounter() {
        let count = userDefaults.integer(forKey: reviewCounterFlag)
        userDefaults.set(count + 1, forKey: reviewCounterFlag)
    }
    
    /// Cheak whether the review counter reaches an amount or not.
    ///
    /// - Parameter count: The amount
    /// - Returns: Whether the review counter reaches the ammount or not.
    public func checkReviewConter(asCount count: Int) -> Bool {
        let savedCount = userDefaults.integer(forKey: reviewCounterFlag)
        return savedCount == count
    }
    
}

extension AppStoreHelper: MessageHelperDelegate {
    
    public func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        let reviewAddress = String(format: AppStoreHelper.reviewAddressPattern, id)
        DeviceHelper.standard.openWebsite(withLink: reviewAddress)
    }
    
}

import Foundation
import StoreKit
