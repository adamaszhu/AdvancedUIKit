final class NavigationViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        navigationItem.rightButtonTitle = Self.navigationRightButtonName
        navigationItem.setRightButtonAction(action: #selector(showNextViewController), withTarget: self)
    }
    
    @objc func showNextViewController() {
        navigationController?.showInitialViewController(ofStoryboard: Self.navigationTitle)
    }
}

private extension NavigationViewController {
    static let navigationTitle = "Navigation"
    static let navigationRightButtonName = "Next"
}

import AdvancedUIKit
import UIKit
