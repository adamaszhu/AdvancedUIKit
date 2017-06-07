/**
 * PopupView is used to popup a view on the screen.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 30/05/2017
 */
public class PopupView: RootView {
    
    /**
     * The default background color of the popup view.
     */
    private static let defaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    /**
     * System error.
     */
    private static let initError = "Constructor init(coder) shouldn't be called."
    
    /**
     * The window of the app.
     */
    public let hostWindow: UIWindow
    
    /**
     * RootViewVisible
     * - parameter shouldAnimate: Whether the animation should be performed or not.
     */
    public override func show() {
        guard !isVisible else {
            Logger.standard.logWarning(RootView.showWarning)
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
            Logger.standard.logWarning(RootView.hideWarning)
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
        super.init(frame: hostWindow.frame)
        alpha = 0
        self.backgroundColor = PopupView.defaultBackgroundColor
        super.hide()
    }
    
    /**
     * UIView
     */
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(PopupView.initError)
        return nil
    }
    
}

import UIKit
