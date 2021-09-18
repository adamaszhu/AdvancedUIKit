#if !os(macOS)
/// ViewController+ActionSheet is used to present an action sheet.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 24/09/2019
public extension UIViewController {
    
    /// Show an action sheet
    ///
    /// - Parameters:
    ///   - title: The title of the action sheet
    ///   - message: The message of the action sheet
    ///   - items: A list of actions
    ///   - view: The view that calls this action sheet. An arrow will be pointed to the center of this view on iPad.
    func showActionSheet(from view: UIView,
                         withTitle title: String?,
                         message: String?,
                         and items: [ActionSheetItem]) {
        let alertController = self.alertController(withTitle: title, message: message, and: items)
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = view.frame
        }
        present(alertController, animated: true)
    }
    
    /// Create an alert controller
    ///
    /// - Parameters:
    ///   - title: The title of the action sheet
    ///   - message: The message of the action sheet
    ///   - items: A list of actions
    private func alertController(withTitle title: String?,
                                 message: String?,
                                 and items: [ActionSheetItem]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        items.forEach { item in
            let action = UIAlertAction(item: item)
            alertController.addAction(action)
        }
        return alertController
    }
}

import UIKit
#endif
