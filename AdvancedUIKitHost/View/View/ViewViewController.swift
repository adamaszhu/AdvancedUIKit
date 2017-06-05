class ViewViewController: UIViewController {
    
    private let popupViewBackgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
    private let animationOffset = CGFloat(100)
    
    @IBOutlet weak var animationButton: UIButton!
    
    private var animationButtonOriginalFrame: CGRect!
    
    private var popupView: PopupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView = PopupView()
        popupView.frame = view.bounds
        popupView.backgroundColor = popupViewBackgroundColor
        let tapGesture = UITapGestureRecognizer(target: popupView, action: #selector(PopupView.hide))
        popupView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationButtonOriginalFrame = animationButton.frame
    }
    
    @IBAction func popup(_ sender: Any) {
        popupView.show()
    }
    
    @IBAction func animate(_ sender: Any) {
        UIView.animate(withChange: { [unowned self] _ in
            self.animationButton.frame.origin = CGPoint(x: self.animationButtonOriginalFrame.origin.x, y: self.animationButtonOriginalFrame.origin.y + self.animationOffset)
        }, withPreparation: { [unowned self] _ in
            self.animationButton.frame = self.animationButtonOriginalFrame
        }) { 
            UIView.animate(withChange: { [unowned self] _ in
                self.animationButton.frame = self.animationButtonOriginalFrame
            })
        }
    }
    
}

import AdvancedUIKit
import UIKit
