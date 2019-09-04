/// InfiniteList is a list that can load infinite items.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 21/06/2017
public class InfiniteList: UITableView {
    
    /// Delegate for action related to the InfiniteList.
    public var infiniteListDelegate: InfiniteListDelegate?
    
    /// The item amount of each page.
    @objc public var pageSize: Int
    
    /// Whether the list can be edited or not.
    @objc public var isEditable: Bool
    
    /// The items displayed on the screen.
    var items: [InfiniteItem]
    
    /// All registered types.
    var cellTypes: [InfiniteCellType]
    
    /// The empty view displayed if no item is retieved.
    @objc var emptyState: UIView?
    
    /// The reloading bar at the top of the list. If it is nil, then reload function will be disabled.
    @objc var reloadingBar: UIView?
    
    /// The loading more bar at the bottom of the list. If it is nil, then load more function will be disabled.
    @objc var loadingMoreBar: UIView?
    
    /// The page amount.
    @objc var pageAmount: Int
    
    /// The index of cell that is currently expanded.
    @objc var expandedCellIndexPath: IndexPath? {
        didSet {
            beginUpdates()
            endUpdates()
        }
    }
    
    /// The status of the list.
    var status: InfiniteListStatus {
        didSet {
            loadingMoreBar?.isHidden = status.isLoadingMoreBarHidden
            loadingMoreBar?.frame.origin = .init(x: 0, y: contentSize.height)
        }
    }
    
    /// Define the nib file used to render an item cell.
    ///
    /// - Parameters:
    ///   - nib: The nib file.
    ///   - type: The item cell type.
    @objc public func register(_ type: InfiniteCell.Type, with nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.cellNibError, withDetail: type)
            return
        }
        let cellType = InfiniteCellType(type: type, basicHeight: view.frame.height, additionalHeight: view.additionalView?.frame.height)
        cellTypes.append(cellType)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
    
    /// Register the empty state view for the InfiniteList.
    ///
    /// - Parameter nib: The nib file containing the view.
    @objc public func registerEmptyState(with nib: UINib) {
        guard status.isRegistrationAvailable else {
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.emptyStateNibError)
            return
        }
        view.frame = bounds
        emptyState = view
    }
    
    /// Show the empty state.
    @objc func showEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard emptyState.superview == nil else {
            Logger.standard.logWarning(InfiniteList.emptyStateShowWarning)
            return
        }
        emptyState.animateChange({
            emptyState.alpha = 1
        }, withPreparation: { [unowned self] in
            emptyState.alpha = 0
            self.addSubview(emptyState)
        })
    }
    
    /// Hide the empty state.
    @objc func hideEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard emptyState.superview != nil else {
            Logger.standard.logWarning(InfiniteList.emptyStateHideWarning)
            return
        }
        emptyState.animateChange({
            emptyState.alpha = 0
        }, withPreparation: {
            emptyState.alpha = 1
        }, withCompletion: {
            emptyState.removeFromSuperview()
        })
    }
    
    /// Find the cell type for a specific cell.
    ///
    /// - Parameter type: The type of the cell.
    /// - Returns: Found cell type. Nil if it is not found.
    func cellType(for type: InfiniteCell.Type) -> InfiniteCellType? {
        for cellType in cellTypes {
            if cellType.type == type {
                return cellType
            }
        }
        Logger.standard.logError(InfiniteList.cellRegistrationError, withDetail: type)
        return nil
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        addReloadingBar()
        addLoadingMoreBar()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        items = []
        cellTypes = []
        status = .initial
        pageAmount = 0
        isEditable = false
        pageSize = InfiniteList.defaultPageSize
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
    
}

extension InfiniteList {
    
    /// System errors.
    @objc static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    @objc static let cellError = "The cell is not an InfiniteCell."
    @objc static let cellRegistrationError = "The cell has not been registered yet."
    @objc static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    @objc static let emptyStateRegistrationError = "The empty state has not been registered yet."
    @objc static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    @objc static let loadingMoreBarNibError = "The nib file doesn't contain a UIView for the loading more bar."
    @objc static let reloadingBarRegistrationError = "The reloading bar hasn't been registered yet."
    @objc static let displayStatusError = "The items cannot be displayed under current status."
    
    /// System warnings.
    @objc static let emptyStateShowWarning = "The empty state has already been shown."
    @objc static let emptyStateHideWarning = "The empty state has already been hidden."
    @objc static let cellExpansionWarning = "The cell cannot be expanded."
    @objc static let cellCollapsionWarning = "The cell cannot be collapsed."
    
    /// The default minimal page size.
    @objc static let defaultPageSize = 10
    
}

import AdvancedFoundation
import UIKit
