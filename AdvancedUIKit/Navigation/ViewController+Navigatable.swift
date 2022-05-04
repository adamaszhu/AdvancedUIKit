#if !os(macOS)
/// ViewController+Navigatable profide additional support related to the navigation.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
public extension UIViewController {
    
    /// Whether the view controller is a root view controller or not.
    var isRootViewController: Bool {
        guard let navigationController = navigationController else {
            return true
        }
        return navigationController.viewControllers.first == self
    }
    
    /// The completion block won't be called if the actual action is popping a view controller
    ///
    /// - Parameters:
    ///   - shouldAnimate: Whether or not there should be a back animation.
    ///   - completion: Completion block after finishing the transaction
    func back(withAnimation shouldAnimate: Bool = true,
              completion: @escaping () -> Void = {}) {
        guard let navigationController = navigationController else {
            dismiss(animated: shouldAnimate, completion: completion)
            return
        }
        if isRootViewController {
            navigationController.dismiss(animated: shouldAnimate, completion: completion)
        } else {
            navigationController.popViewController(animated: shouldAnimate)
            completion()
        }
    }

    /// Setup the back button
    ///
    /// - Parameters:
    ///   - backTitle: The title of the back button if there is a previous view controller.
    ///   - backImage: The image of the back button if there is a previous view controller.
    ///   - cancelTitle: The title of the cancel button if the current view controller is the root view controller.
    ///   - cancelImage: The image of the cancel button if the current view controller is the root view controller.
    func setupBackButton(withBackTitle backTitle: String? = nil,
                         withBackImage backImage: UIImage? = nil,
                         withCancelTitle cancelTitle: String? = nil,
                         withCancelImage cancelImage: UIImage? = nil) {
        guard let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 else {
            navigationItem.leftBarButtonItem = cancelImage != nil
                ? UIBarButtonItem(image: cancelImage?.withRenderingMode(.alwaysOriginal),
                                  style: .plain,
                                  target: self,
                                  action: #selector(backAction))
                : UIBarButtonItem(title: cancelTitle ?? Self.cancel.localizedInternalString(forType: Self.self),
                                  style: .plain,
                                  target: self,
                                  action: #selector(backAction))
            return
        }
        let previousViewController = navigationController?.viewControllers[index - 1]
        if let backTitle = backTitle {
            previousViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: backTitle,
                                                                                       style: .plain,
                                                                                       target: self,
                                                                                       action: #selector(backAction))
        } else if let backImage = backImage {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage.withRenderingMode(.alwaysOriginal),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(backAction))
        } else {
            // Use the default one
            previousViewController?.navigationItem.backBarButtonItem = nil
        }
    }
    
    /// Perform the back action
    @objc open func backAction() {
        back()
    }
}

/// Constants
private extension UIViewController {
    static let cancel = "Cancel"
}

import UIKit
#endif
