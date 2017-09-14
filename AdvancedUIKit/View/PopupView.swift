/// PopupView is used to popup a view on the screen.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 30/05/2017
public class PopupView: RootView {
    
    /// The window of the app.
    public let hostWindow: UIWindow
    
    /// Initialize the view.
    ///
    /// - Parameter application: The application that contains the window.
    public init(application: UIApplication = UIApplication.shared) {
        hostWindow = application.windows[0]
        super.init(frame: hostWindow.frame)
        alpha = 0
        self.backgroundColor = PopupView.defaultBackgroundColor
        super.hide()
    }
    
    public override func show() {
        guard !isVisible else {
            Logger.standard.log(warning: RootView.showingWarning)
            return
        }
        hostWindow.addSubview(self)
        animate(withChange: { [unowned self] _ in
            self.alpha = 1
        }) {
            super.show()
        }
    }
    
    public override func hide() {
        guard isVisible else {
            Logger.standard.log(warning: RootView.hidingWarning)
            return
        }
        animate(withChange: {[unowned self] _ in
            self.alpha = 0
        }) {
            self.removeFromSuperview()
            super.hide()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.log(error: PopupView.initError)
        return nil
    }
    
}

import UIKit
