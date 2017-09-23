/// DeviceHelper+MailComposeViewControllerDelegate delegates the task for sending an email.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 29/05/2017
extension DeviceHelper: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
        case .sent:
            deviceHelperDelegate?.deviceHelper(self, didSendEmail: true)
        default:
            deviceHelperDelegate?.deviceHelper(self, didSendEmail: false)
        }
    }
    
}

import Foundation
import MessageUI
