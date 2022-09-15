#if !os(macOS)
/// BottomSheetViewController is used to present a view controller from the bottom.
///
/// - author: Adamas
/// - version: 1.9.7
/// - date: 15/09/2022
open class BottomSheetViewController: ModalViewController {

    /// The view that hold the sub view controller
    private var modalView: UIView = UIView()

    /// Whether the view controller has been initialized or not
    private var isInitialized: Bool = false

    /// Define the present mode of the bottom sheet
    private var mode: BottomSheetMode

    /// The bottom constraints of the modal
    private var modalBottomConstraint: NSLayoutConstraint?

    /// Create the bottom sheet view controller for a specified controller
    /// - Parameters:
    ///   - viewController: The actual view controller to present
    ///   - mode: The presenting mode
    public init(viewController: UIViewController, mode: BottomSheetMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        addChild(viewController)
    }

    public required init?(coder aDecoder: NSCoder) {
        mode = .auto
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
        if !isInitialized {
            isInitialized = true
            showModal()
        }
    }

    /// Show the bottom sheet.
    /// 
    /// - Parameter completion: Comletion handler for showing the bottom sheet.
    public func showModal(completion: (() -> Void)? = nil) {
        modalView.animateChange({ [weak self] in
            self?.modalBottomConstraint?.isActive = true
            self?.view.layoutIfNeeded()
        }, completion: {
            completion?()
        })
    }

    /// Hide the bottom sheet.
    ///
    /// - Parameter completion: Comletion handler for hiding the bottom sheet.
    public func hideModal(completion: (() -> Void)? = nil) {
        modalView.animateChange({ [weak self] in
            self?.modalBottomConstraint?.isActive = false
            self?.view.layoutIfNeeded()
        }, completion: {
            completion?()
        })
    }

    /// Setup the modal view with the actual view controller
    private func setupModalView() {
        guard let childViewController = children.first else {
            return
        }
        switch mode {
        case let .ratio(ratio):
            let height = view.bounds.width / CGFloat(ratio)
            modalView.heightAnchor.constraint(equalToConstant: height).isActive = true
        case let .percentage(percentage):
            let height = view.bounds.height * CGFloat(percentage)
            modalView.heightAnchor.constraint(equalToConstant: height).isActive = true
        default:
            break
        }
        modalView.addSubview(childViewController.view)
        childViewController.view.pinEdgesToSuperview()

        modalView.pinHorizontalEdgesToSuperview()
        let modalTopConstraint = modalView.topAnchor.constraint(equalTo: view.bottomAnchor)
        modalTopConstraint.priority = .defaultLow
        modalTopConstraint.isActive = true
        modalBottomConstraint = modalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
