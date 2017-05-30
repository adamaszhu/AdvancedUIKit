/**
 * PopupView is used to popup a view on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
public class PopupView: RootView, RootViewVisible {
    
    /**
     * The default background color of the popup view.
     */
    private let defaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    /**
     * The window of the app.
     */
    public let hostWindow: UIWindow
    
    /**
     * The background view.
     */
    private let backgroundView: UIView
    
    /**
     * RootViewVisible
     * - parameter shouldAnimate: Whether the animation should be performed or not.
     */
    public override func show() {
        guard !isVisible else {
            return
        }
        hostWindow.addSubview(self)
        animate(withChange: { [unowned self] _ in
            self.alpha = 1
        }) {
            super.show()
        }
    }
    
    /**
     * RootViewVisible.
     */
    public override func hide() {
        guard isVisible else {
            return
        }
        animate(withChange: {[unowned self] _ in
            self.alpha = 0
        }) {
            self.removeFromSuperview()
            super.hide()
        }
    }
    
    /**
     * Initialize the view.
     * - parameter application: The application that contains the window.
     */
    public init(application: UIApplication = UIApplication.shared) {
        hostWindow = application.windows[0]
        backgroundView = UIView(frame: hostWindow.frame)
        super.init(frame: hostWindow.frame)
        alpha = 0
        backgroundView.backgroundColor = defaultBackgroundColor
        addSubview(backgroundView)
        super.hide()
    }
    
    /**
     * UIView
     */
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}

import UIKit
