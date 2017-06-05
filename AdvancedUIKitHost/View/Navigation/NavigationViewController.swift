class NavigationViewController: UIViewController {
    
    private let navigation = (title: "Navigation", leftButtonName: "Back", rightButtonName: "Done")
    private let doneMessage = "Click the done button."
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.viewController = self
        navigationBar.title = navigation.title
        navigationBar.rightButtonTitle = navigation.rightButtonName
        navigationBar.leftButtonTitle = navigation.leftButtonName
        navigationBar.setLeftButtonAction(action: #selector(NavigationBar.back), withTarget: navigationBar)
        navigationBar.setRightButtonAction(action: #selector(done), withTarget: self)
    }
    
    func done() {
        SystemMessageHelper.standard?.showInfo(doneMessage)
    }
    
}

import AdvancedUIKit
import UIKit
