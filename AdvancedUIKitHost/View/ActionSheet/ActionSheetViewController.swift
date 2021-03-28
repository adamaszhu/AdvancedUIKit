final class ActionSheetViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBAction func showActionSheet(_ sender: Any) {
        let action1 = ActionSheetItem(title: Self.action1) {
            self.messageHelper?.showInfo(Self.action1)
        }
        let action2 = ActionSheetItem(title: Self.action2, icon: UIImage(named: Self.actionIcon)) {
            self.messageHelper?.showInfo(Self.action2)
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = Self.actionColor
        let action3 = ActionSheetItem(viewController: viewController)
        let action4 = ActionSheetItem(title: Self.cancelAction, style: .cancel)
        showActionSheet(from: view, withTitle: Self.actionTitle, message: Self.actionMessage, and: [action1, action2, action3, action4])
    }
}

private extension ActionSheetViewController {
    static let actionTitle = "Action Sheet"
    static let actionMessage = "This is an action sheet"
    static let action1 = "Action 1"
    static let action2 = "Action 2"
    static let actionIcon = "Logo"
    static let actionColor = UIColor(red: 0.49, green: 0.712, blue: 0.845, alpha: 1)
    static let cancelAction = "Cancel"
}

import AdvancedUIKit
import UIKit
