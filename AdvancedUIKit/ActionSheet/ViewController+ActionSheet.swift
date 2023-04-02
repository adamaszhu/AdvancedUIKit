#if !os(macOS)
/// ViewController+ActionSheet is used to present an action sheet.
///
/// - author: Adamas
/// - version: 1.9.15
/// - date: 28/03/2023
public extension UIViewController {
    
    /// Show an action sheet
    ///
    /// - Parameters:
    ///   - title: The title of the action sheet
    ///   - message: The message of the action sheet
    ///   - items: A list of actions
    ///   - view: The view that calls this action sheet. An arrow will be pointed to the center of this view on iPad.
    ///   - interfaceIdom: The interface idom of the device.
    func showActionSheet(from view: UIView,
                         withTitle title: String?,
                         message: String?,
                         and items: [ActionSheetItem],
                         under interfaceIdiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom) {
        let alertController = self.alertController(withTitle: title, message: message, and: items)
        if interfaceIdiom == .pad {
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
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        items.map(UIAlertAction.init)
            .forEach(alertController.addAction)
        return alertController
    }
}

import UIKit
#endif
