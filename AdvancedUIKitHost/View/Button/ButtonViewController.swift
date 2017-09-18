final class ButtonViewController: UIViewController {
    
    private let buttonTitle = "Button\nTitle"
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = buttonTitle
    }
    
}

import UIKit
