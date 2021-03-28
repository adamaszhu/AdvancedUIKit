final class ApplicationViewController: UIViewController {
    
    private let appStoreHelper: AppStoreHelper = AppStoreHelper(id: ApplicationViewController.appID, reviewCounterFlag: ApplicationViewController.flagPattern)
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBAction func rate(_ sender: Any) {
        if appStoreHelper.checkReviewCounter(asCount: Self.ratingCounter) {
            appStoreHelper.review()
        } else {
            appStoreHelper.increaseReviewCounter()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        appStoreHelper.resetReviewCounter()
    }
    
    @IBAction func detectGoogleMap(_ sender: Any) {
        let result = ApplicationHelper.shared.isApplicationInstalled(with: .googleMap)
        messageHelper?.showInfo("\(result)")
    }
}

private extension ApplicationViewController {
    static let appID = "364709193"
    static let flagPattern = "AppStore%@"
    static let ratingCounter = 3
}

import AdvancedUIKit
import UIKit
