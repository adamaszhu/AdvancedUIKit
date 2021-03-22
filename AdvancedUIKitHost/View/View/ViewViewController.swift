final class ViewViewController: UIViewController {
    
    private var animationButtonOriginalFrame: CGRect!
    private var popupView: PopupView = PopupView()
    
    @IBOutlet private weak var animationButton: UIButton!
    @IBOutlet private weak var staticView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPopupView()
        configAnimationView()
        configStaticView()
    }
    
    @IBAction func popup(_ sender: Any) {
        popupView.show()
    }
    
    @IBAction func animate(_ sender: Any) {
        animationButton.animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.animationButton.frame.origin = CGPoint(x: self.animationButtonOriginalFrame.origin.x, y: self.animationButtonOriginalFrame.origin.y - Self.animationOffset)
            self.staticView.height = 0
            self.view.layoutIfNeeded()
        }, preparation: { [weak self] in
            guard let self = self else {
                return
            }
            self.animationButton.frame = self.animationButtonOriginalFrame
            self.staticView.height = Self.staticViewHeight
        }) { [weak self] in
            self?.animationButton.animateChange({ [weak self] in
                guard let self = self else {
                    return
                }
                self.animationButton.frame = self.animationButtonOriginalFrame
                self.staticView.height = Self.staticViewHeight
                self.view.layoutIfNeeded()
            })
        }
    }
    
    private func configPopupView() {
        popupView.frame = view.bounds
        popupView.backgroundColor = Self.popupViewBackgroundColor
        let tapGesture = UITapGestureRecognizer(target: popupView, action: #selector(PopupView.hide))
        popupView.addGestureRecognizer(tapGesture)
    }
    
    private func configAnimationView() {
        animationButtonOriginalFrame = animationButton.frame
    }
    
    private func configStaticView() {
        staticView.height = Self.staticViewHeight
        staticView.pinEdgesToSuperview(with: UIEdgeInsets.init(top: Self.staticViewMargin, left: Self.staticViewMargin, bottom: .invalidInset, right: Self.staticViewMargin))
    }
}

private extension ViewViewController {
    static let popupViewBackgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
    static let animationOffset = CGFloat(200)
    static let staticViewHeight = CGFloat(50)
    static let staticViewMargin = CGFloat(10)
}

import AdvancedUIKit
import UIKit
