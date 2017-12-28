final class NavigationViewController: UIViewController {
    
    let navigation = (title: "Navigation", leftButtonName: "Back", rightButtonName: "Done")
    let navigationColor = UIColor.red
    let navigationTintColor = UIColor.white
    let doneMessage = "Click the done button."
    
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

import AdvancedUIKit
import UIKit
