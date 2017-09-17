final class ButtonViewController: UIViewController {
    
    private let buttonTitle = "Button\nTitle"
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = buttonTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.layer.cornerRadius = button.actualHeight
    }
    
}

import UIKit
