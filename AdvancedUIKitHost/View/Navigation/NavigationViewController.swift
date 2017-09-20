final class NavigationViewController: UIViewController {
    
    private let navigation = (title: "Navigation", leftButtonName: "Back", rightButtonName: "Done")
    private let navigationColor = UIColor.red
    private let navigationTintColor = UIColor.white
    private let doneMessage = "Click the done button."
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.viewController = self
        navigationBar.tintColor = navigationTintColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: navigationTintColor]
        navigationBar.backgroundColor = navigationColor
        navigationBar.title = navigation.title
        navigationBar.rightButtonTitle = navigation.rightButtonName
        navigationBar.leftButtonTitle = navigation.leftButtonName
        navigationBar.setLeftButtonAction(action: #selector(NavigationBar.back), withTarget: navigationBar)
        navigationBar.setRightButtonAction(action: #selector(done), withTarget: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationBar.animate(withChange: { [unowned self] _ in
            self.navigationController?.navigationBar.alpha = 0
            }, withCompletion: { [unowned self] _ in
                self.navigationController?.isNavigationBarHidden = true
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func done() {
        SystemMessageHelper.standard?.showInfo(doneMessage)
    }
    
}

import AdvancedUIKit
import UIKit
