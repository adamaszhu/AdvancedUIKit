final class NavigationViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.viewController = self
        navigationBar.tintColor = navigationTintColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: navigationTintColor]
        navigationBar.backgroundColor = navigationColor
        navigationBar.title = navigation.title
        navigationBar.rightButtonTitle = navigation.rightButtonName
        navigationBar.leftButtonTitle = navigation.leftButtonName
        navigationBar.setLeftButtonAction(action: #selector(NavigationBar.back), withTarget: navigationBar)
        navigationBar.setRightButtonAction(action: #selector(done), withTarget: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func done() {
        SystemMessageHelper.standard?.showInfo(doneMessage)
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
