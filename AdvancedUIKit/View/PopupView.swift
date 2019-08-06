/// PopupView is used to popup a view on the screen.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 06/08/2019
open class PopupView: RootView {
    
    /// The window of the app.
    private let hostWindow: UIWindow
    
    /// Initialize the view.
    ///
    /// - Parameter window: The window that contains the pop up.
    public init(window: UIWindow? = UIApplication.shared.windows.first) {
        hostWindow = window ?? UIWindow(frame: .zero)
        super.init(frame: hostWindow.frame)
        alpha = 0
        self.backgroundColor = PopupView.defaultBackgroundColor
        super.hide()
    }
    
    @objc open override func show() {
        guard !isVisible else {
            Logger.standard.logWarning(PopupView.showingWarning)
            return
        }
        hostWindow.addSubview(self)
        animateChange({ [weak self] in
            self?.alpha = 1
        }) {
            super.show()
        }
    }
    
    @objc open override func hide() {
        guard isVisible else {
            Logger.standard.logWarning(PopupView.hidingWarning)
            return
        }
        animateChange({ [weak self] in
            self?.alpha = 0
        }) {
            self.removeFromSuperview()
            super.hide()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        Logger.standard.logError(PopupView.initError)
        return nil
    }
    
}

/// Constants
private extension PopupView {
    
    /// The default background color of the popup view.
    static let defaultBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
}

/// Constants
extension PopupView {
    
    /// System error.
    static let initError = "Constructor init(coder) shouldn't be called."
}

import AdvancedFoundation
import UIKit
