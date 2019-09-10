final class NavigationViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.viewController = self
        navigationBar.tintColor = NavigationViewController.navigationTintColor
        navigationBar.titleTextAttributes = [.foregroundColor: NavigationViewController.navigationTintColor]
        navigationBar.backgroundColor = NavigationViewController.navigationColor
        navigationBar.title = NavigationViewController.navigationTitle
        navigationBar.rightButtonTitle = NavigationViewController.navigationRightButtonName
        navigationBar.leftButtonTitle = NavigationViewController.navigationLeftButtonName
        navigationBar.setLeftButtonAction(action: #selector(NavigationBar.back), withTarget: navigationBar)
        navigationBar.setRightButtonAction(action: #selector(done), withTarget: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func done() {
        messageHelper?.showInfo(NavigationViewController.doneMessage)
    }
}

private extension NavigationViewController {
    static let navigationTitle = "Navigation"
    static let navigationLeftButtonName = "Back"
    static let navigationRightButtonName = "Done"
    static let navigationColor = UIColor.red
    static let navigationTintColor = UIColor.white
    static let doneMessage = "Click the done button."
}

import AdvancedUIKit
import UIKit
