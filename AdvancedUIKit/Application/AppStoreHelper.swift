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
    
    /// The user default used to save the counter.
    private let userDefaults: UserDefaults
    
    /// Initialize the helper
    ///
    /// - Parameter
    ///   - id: The app store id.
    ///   - reviewCounterFlag: The flag used to record the review counter.
    ///   - userDefaults: The user defaults used to store flags.
    ///   - messageHelper: The message helper used to show a popup.
    ///   - deviceHelper: The device helper used to open a website.
    public init(id: String,
                reviewCounterFlag: String,
                userDefaults: UserDefaults = .standard) {
        self.id = id
        self.reviewCounterFlag = reviewCounterFlag
        self.userDefaults = userDefaults
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

import AdvancedFoundation
import Foundation
import StoreKit
#endif
