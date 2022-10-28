#if !os(macOS)
/// AppStoreHelper provides support for rating the app.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/05/2019
public final class AppStoreHelper {
    
    /// The app store id
    private let id: String
    
    /// The flag used to record the review counter.
    private let reviewCounterFlag: String
    
    /// The message helper
    private let messageHelper: SystemMessageHelper?
    
    /// The user default used to save the counter.
    private let userDefaults: UserDefaults
    
    /// The device helper for opening a website.
    private let deviceHelper: DeviceHelper
    
    /// Initialize the helper
    ///
    /// - Parameter
    ///   - id: The app store id.
    ///   - reviewCounterFlag: The flag used to record the review counter.
    ///   - userDefaults: The user defaults used to store flags.
    ///   - messageHelper: The message helper used to show a popup.
    ///   - deviceHelper: The device helper used to open a website.
    public init(id: String, reviewCounterFlag: String,
                userDefaults: UserDefaults = UserDefaults.standard,
                messageHelper: SystemMessageHelper? = SystemMessageHelper(),
                deviceHelper: DeviceHelper = DeviceHelper()) {
        self.id = id
        self.reviewCounterFlag = reviewCounterFlag
        self.userDefaults = userDefaults
        self.messageHelper = messageHelper
        self.deviceHelper = deviceHelper
        messageHelper?.delegate = self
    }
    
    /// Leave a review in the app store.
    public func review() {
        SKStoreReviewController.requestReview()
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
    public func checkReviewCounter(asCount count: Int) -> Bool {
        let savedCount = userDefaults.integer(forKey: reviewCounterFlag)
        return savedCount == count
    }
    
    /// Reset the counter
    public func resetReviewCounter() {
        userDefaults.removeObject(forKey: reviewCounterFlag)
    }
}

/// MessageHelperDelegate
extension AppStoreHelper: MessageHelperDelegate {
    
    public func messageHelperDidConfirmWarning(_ messageHelper: MessageHelper) {
        let reviewAddress = String(format: Self.reviewAddressPattern, id)
        deviceHelper.openWebsite(withLink: reviewAddress)
    }
    
    public func messageHelper(_ messageHelper: MessageHelper, didConfirmInput content: String) {}
}

/// Constants
private extension AppStoreHelper {
    
    /// The review address pattern.
    static var reviewAddressPattern = "itms-apps://itunes.apple.com/app/id%@"
}

import AdvancedFoundation
import Foundation
import StoreKit
#endif
