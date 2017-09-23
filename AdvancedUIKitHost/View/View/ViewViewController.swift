final class ViewViewController: UIViewController {
    
    let popupViewBackgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
    let animationOffset = CGFloat(100)
    
    var animationButtonOriginalFrame: CGRect!
    var popupView = PopupView()
    
    @IBOutlet weak var animationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.frame = view.bounds
        popupView.backgroundColor = popupViewBackgroundColor
        let tapGesture = UITapGestureRecognizer(target: popupView, action: #selector(PopupView.hide))
        popupView.addGestureRecognizer(tapGesture)
        animationButtonOriginalFrame = animationButton.frame
    }
    
    @IBAction func popup(_ sender: Any) {
        popupView.show()
    }
    
    @IBAction func animate(_ sender: Any) {
        animationButton.animate(withChange: { [unowned self] _ in
            self.animationButton.frame.origin = .init(x: self.animationButtonOriginalFrame.origin.x, y: self.animationButtonOriginalFrame.origin.y + self.animationOffset)
        }, withPreparation: { [unowned self] _ in
            self.animationButton.frame = self.animationButtonOriginalFrame
        }) { [unowned self] _ in
            self.animationButton.animate(withChange: { [unowned self] _ in
                self.animationButton.frame = self.animationButtonOriginalFrame
            })
        }
    }
    
}

import AdvancedUIKit
import UIKit
