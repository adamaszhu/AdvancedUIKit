class NavigationViewController: UIViewController {
    
    private let navigation = (title: "Navigation", leftButtonName: "Back", rightButtonName: "Done")
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = navigation.title
        navigationBar.rightButtonTitle = navigation.rightButtonName
        navigationBar.leftButtonTitle = navigation.leftButtonName
    }
    
}

import AdvancedUIKit
import UIKit
