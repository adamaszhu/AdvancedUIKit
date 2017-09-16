final class ButtonViewController: UIViewController {
    
    static private let buttonTitle = "Button\nTitle"
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = ButtonViewController.buttonTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.layer.cornerRadius = button.actualHeight
    }
    
}

import UIKit
