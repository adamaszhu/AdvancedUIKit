/// ActionSheetItem is used to present an action.
///
/// - author: Adamas
/// - version: 1.6.0
/// - date: 24/09/2019
public struct ActionSheetItem {
    
    /// Item title.
    fileprivate let title: String?
    
    /// Item icon.
    fileprivate let icon: UIImage?
    
    /// Item action.
    fileprivate let action: (() -> Void)?
    
    /// Item style.
    fileprivate let style: UIAlertAction.Style
    
    /// A view controller defined item.
    fileprivate let viewController: UIViewController?
    
    /// Create an action item.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - icon: The icon. Nil by default.
    ///   - action: The action.
    public init(title: String,
                icon: UIImage? = nil,
                action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
        style = .default
        viewController = nil
    }
    
    /// Create a cancellation or destruction item.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - style: The style.
    public init(title: String, style: UIAlertAction.Style) {
        self.style = style
        self.title = title
        icon = nil
        action = nil
        viewController = nil
    }
    
    /// Create an item using a view controller. Better to keep the background of the view controller to be clear.
    ///
    /// - Parameter viewController: The view controller.
    public init(viewController: UIViewController) {
        self.viewController = viewController
        style = .default
        title = viewController.title ?? .empty
        icon = nil
        action = nil
    }
}

// UIAlertAction Conversion
extension UIAlertAction {
    
    /// Convert an ActionSheetItem into an UIAlertAction
    ///
    /// - Parameter item: The data model of an alert action
    convenience init(item: ActionSheetItem) {
        self.init(title: item.title, style: item.style) { _ in
            item.action?()
        }
        setValue(item.icon?.withRenderingMode(.alwaysOriginal), forKey: Self.imageKey)
        setValue(item.viewController, forKey: Self.viewControllerKey)
    }
}

/// Constants
private extension UIAlertAction {
    static let imageKey = "image"
    static let viewControllerKey = "contentViewController"
}

import UIKit
