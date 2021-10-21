#if !os(macOS)
/// BottomSheetViewController is used to present a view controller from the bottom.
///
/// - author: Adamas
/// - version: 1.7.3
/// - date: 02/10/2021
open class BottomSheetViewController: ModalViewController {

    /// The view that hold the sub view controller
    private var modalView: UIView = UIView()

    /// Whether the view controller has been initialized or not
    private var isInitialized: Bool = false

    /// Define the ratio of the bottom sheet
    private var ratio: Double? = nil

    /// Create the bottom sheet view controller for a specified controller
    /// - Parameters:
    ///   - viewController: The actual view controller to present
    ///   - ratio: The ratio of the pop up view, default to 0.85
    public init(viewController: UIViewController, ratio: Double? = nil) {
        self.ratio = ratio
        super.init(nibName: nil, bundle: nil)
        addChild(viewController)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(modalView)
        view.backgroundColor = Self.backgroundColor
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !isInitialized else {
            return
        }
        setupModalView()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isInitialized else {
            return
        }
        isInitialized = true
        showModal()
    }

    /// Show the bottom sheet.
    /// 
    /// - Parameter completion: Comletion handler for showing the bottom sheet.
    public func showModal(completion: (() -> Void)? = nil) {
        modalView.animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.modalView.frame.origin.y = self.view.bounds.height - self.modalView.bounds.height
        }, preparation: {
            modalView.frame.origin.y = view.bounds.height
        }, completion: {
            completion?()
        })
    }


    /// Hide the bottom sheet.
    ///
    /// - Parameter completion: Comletion handler for hiding the bottom sheet.
    public func hideModal(completion: (() -> Void)? = nil) {
        modalView.animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.modalView.frame.origin.y = self.view.bounds.height
        }, preparation: {
            modalView.frame.origin.y = view.bounds.height - modalView.bounds.height
        }, completion: {
            completion?()
        })
    }

    /// Setup the modal view with the actual view controller
    private func setupModalView() {
        guard let childViewController = children.first else {
            return
        }
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.frame.origin = CGPoint(x: 0, y: view.bounds.height)
        let height: CGFloat
        if let ratio = ratio {
            height = view.bounds.width * CGFloat(ratio)
        } else {
            height = view.bounds.height * Self.modalHeightPercentage
        }
        modalView.frame.size = CGSize(width: view.bounds.width,
                                      height: height)
        modalView.addSubview(childViewController.view)
        childViewController.view.frame.size = modalView.frame.size
    }

    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        hideModal {
            super.dismiss(animated: flag, completion: completion)
        }
    }
}

private extension BottomSheetViewController {
    static let backgroundColor = UIColor(white: 0, alpha: 0.6)
    static let modalHeightPercentage: CGFloat = 0.85
}

import UIKit
#endif
