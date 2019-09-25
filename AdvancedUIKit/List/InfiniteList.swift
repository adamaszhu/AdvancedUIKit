/// InfiniteList is a list that can load infinite items.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/09/2019
open class InfiniteList: UITableView {
    
    /// Delegate for action related to the InfiniteList.
    public weak var infiniteListDelegate: InfiniteListDelegate?
    
    /// Whether the list can be edited or not.
    public var isEditable: Bool = false
    
    /// The item amount of each page.
    public var pageSize: Int = InfiniteList.defaultPageSize
    
    /// The page amount.
    private var pageAmount: Int = 0
    
    /// The items displayed on the screen.
    private var items: [InfiniteItem] = []
    
    /// The empty view displayed if no item is retieved.
    private weak var emptyState: UIView?
    
    /// The reloading bar at the top of the list. If it is nil, then reload function will be disabled.
    private var reloadingBar: UIView?
    
    /// The loading more bar at the bottom of the list. If it is nil, then load more function will be disabled.
    private var loadingMoreCell: UITableViewCell?
    
    /// The index of cell that is currently expanded.
    private var expandedCellIndexPath: IndexPath? {
        didSet {
            beginUpdates()
            endUpdates()
        }
    }
    
    /// The status of the list.
    private var status: InfiniteListStatus
    
    /// Define the nib file used to render an item cell.
    ///
    /// - Parameters:
    ///   - nib: The nib file.
    ///   - type: The item cell type.
    public func register(_ type: InfiniteCell.Type, with nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registrationError)
            return
        }
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
    
    /// Register the empty state view for the InfiniteList.
    ///
    /// - Parameter nib: The nib file containing the view.
    public func registerEmptyState(with nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registrationError)
            return
        }
        guard let superview = superview else {
            Logger.standard.logError(InfiniteList.superviewError)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.emptyStateNibError)
            return
        }
        superview.addSubview(view)
        view.pinEdgesToSuperview()
        view.isHidden = true
        emptyState = view
    }
    
    /// Register the reload view for the InfiniteList.
    ///
    /// - Parameter nib: The nib file containing the view.
    public func registerReloadingBar(with nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registrationError)
            return
        }
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            Logger.standard.logError(InfiniteList.reloadingBarNibError)
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview(with: UIEdgeInsets(top: .invalidInset, left: 0, bottom: .invalidInset, right: 0))
        view.bottomAnchor.constraint(equalTo: topAnchor).isActive = true
        view.isHidden = true
        reloadingBar = view
    }
    
    /// Register the load more cell for the InfiniteList.
    ///
    /// - Parameter nib: The nib file containing the cell.
    public func registerLoadingMoreCell(with nib: UINib) {
        guard status == .initial else {
            Logger.standard.logError(InfiniteList.registrationError)
            return
        }
        guard let cell = nib.instantiate(withOwner: nil, options: nil).first as? UITableViewCell else {
            Logger.standard.logError(InfiniteList.loadingMoreCellNibError)
            return
        }
        loadingMoreCell = cell
    }
    
    /// Perform drag and reload function programmatically.
    public func startReloading() {
        guard let _ = reloadingBar else {
            Logger.standard.logError(InfiniteList.reloadingBarRegistrationError)
            return
        }
        guard status.isReloadingAvailable else {
            return
        }
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.contentOffset = CGPoint(x: 0, y: self.reloadingOffsetY)
            }, withCompletion: { [weak self] in
                guard let self = self else {
                    return
                }
                self.status = .reloading
                self.infiniteListDelegate?.infiniteListDidRequireReload(self)
        })
    }
    
    /// Display a list of item depending on the status of the InfiniteList.
    ///
    /// - Parameter items: The item to be displayed.
    public func display(_ items: [InfiniteItem]) {
        switch status {
        case .initial, .reloading:
            reload(items)
        case .loadingMore:
            append(items)
        default:
            Logger.standard.logError(InfiniteList.displayStatusError)
        }
        // Adjust the content offset.
        if contentOffset.y < 0 {
            setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    /// Expand a specific cell.
    ///
    /// - Parameter indexPath: The index path of the cell.
    private func expandCell(at indexPath: IndexPath) {
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellExpansionWarning, withDetail: index)
            return
        }
        cell.expand()
        expandedCellIndexPath = indexPath
    }
    
    /// Collapse a specific cell.
    ///
    /// - Parameter indexPath: The index path of the cell.
    private func collapseCell(at indexPath: IndexPath) {
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell, cell.isExpandable else {
            Logger.standard.logWarning(InfiniteList.cellCollapsionWarning, withDetail: index)
            return
        }
        cell.collapse()
        expandedCellIndexPath = nil
    }
    
    /// Show the empty state.
    private func showEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard emptyState.isHidden else {
            Logger.standard.logWarning(InfiniteList.emptyStateShowWarning)
            return
        }
        emptyState.animateChange({
            emptyState.alpha = 1
        }, withPreparation: {
            emptyState.alpha = 0
            emptyState.isHidden = false
        })
    }
    
    /// Hide the empty state.
    private func hideEmptyState() {
        guard let emptyState = emptyState else {
            Logger.standard.logError(InfiniteList.emptyStateRegistrationError)
            return
        }
        guard !emptyState.isHidden else {
            Logger.standard.logWarning(InfiniteList.emptyStateHideWarning)
            return
        }
        emptyState.animateChange({
            emptyState.alpha = 0
        }, withPreparation: {
            emptyState.alpha = 1
            emptyState.isHidden = false
        }, withCompletion: {
            emptyState.isHidden = true
        })
    }
    
    /// Reload a list of items.
    ///
    /// - Parameter items: The items to be reloaded.
    private func reload(_ items: [InfiniteItem]) {
        guard status.isReloadingItemAvailable else {
            return
        }
        self.items = items
        pageAmount = 1
        reloadData()
        expandedCellIndexPath = nil
        switch items.count {
        case 0:
            status = .empty
            showEmptyState()
        case 1 ..< pageSize:
            status = .finite
            hideEmptyState()
        default:
            status = .infinite
            hideEmptyState()
        }
    }
    
    /// Append a list of items.
    ///
    /// - Parameter items: The items to be append.
    private func append(_ items: [InfiniteItem]) {
        guard status.isLoadingMoreItemAvailable else {
            return
        }
        self.items = self.items + items
        pageAmount = pageAmount + 1
        reloadData()
        switch items.count {
        case 0 ..< pageSize:
            status = .finite
        default:
            status = .infinite
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        status = .initial
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
}

/// UITableViewDelegate
extension InfiniteList: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items.element(atIndex: indexPath.row), status.isStable else {
            return
        }
        infiniteListDelegate?.infiniteList(self, didSelectItem: item.item)
    }
}

/// UITableViewDataSource
extension InfiniteList: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let hasLoadingMoreCell = status.isStable && (loadingMoreCell != nil)
        //isLoadingMoreAvailable
        return items.count + (hasLoadingMoreCell ? 1 : 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == items.count, status.isStable, let loadingMoreCell = loadingMoreCell {
            return loadingMoreCell
        }
        guard let item = items.element(atIndex: index) else {
            return UITableViewCell()
        }
        let cellID = String(describing: item.type)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InfiniteCell else {
            Logger.standard.logError(InfiniteList.cellError, withDetail: cellID)
            return UITableViewCell()
        }
        cell.render(withItem: item.item)
        guard cell.isExpandable else {
            return cell
        }
        if indexPath == expandedCellIndexPath {
            cell.expand()
        } else {
            cell.collapse()
        }
        cell.switchExpandStatusAction = { [weak self] in
            guard let self = self else {
                return
            }
            if self.expandedCellIndexPath == indexPath {
                self.collapseCell(at: indexPath)
                return
            }
            if let previousExpandedCellIndexPath = self.expandedCellIndexPath {
                // Collapse previous expanded cell.
                self.collapseCell(at: previousExpandedCellIndexPath)
            }
            self.expandCell(at: indexPath)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard status.isEditingAvailable else {
            return false
        }
        guard let cell = cellForRow(at: indexPath) as? InfiniteCell else {
            return false
        }
        // If a cell can be expanded, it should implement those editable feature in the additional view.
        return isEditable && !cell.isExpandable
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard status.isEditingAvailable, let item = items.element(atIndex: indexPath.row)?.item else {
                return
            }
            items.remove(at: indexPath.row)
            if items.count != 0 {
                deleteRows(at: [indexPath], with: .automatic)
            } else {
                status = .empty
            }
            reloadData()
            infiniteListDelegate?.infiniteList(self, didDeleteItem: item)
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell == loadingMoreCell {
            status = .loadingMore
            infiniteListDelegate?.infiniteList(self, didRequireLoadPage: pageAmount)
        }
    }
}

/// UIScrollViewDelegate
extension InfiniteList: UIScrollViewDelegate {
    
    /// The y offset for reloading status.
    private var reloadingOffsetY: CGFloat {
        let reloadingBarHeight = reloadingBar?.frame.height ?? 0
        return -reloadingBarHeight
    }
    
    /// The y offset for displaying the last item.
    private var bottomOffsetY: CGFloat {
        return max(contentSize.height - frame.height, 0)
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        infiniteListDelegate?.infiniteListDidScroll(self)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch status {
        case .reloading, .initial:
            contentOffset = .init(x: 0, y: reloadingOffsetY)
            return
        case .loadingMore:
            contentOffset = .init(x: 0, y: bottomOffsetY)
            return
        case .finite, .empty, .infinite:
            if contentOffset.y >= bottomOffsetY {
                contentOffset = .init(x: 0, y: bottomOffsetY)
            }
        }
        if contentOffset.y <= reloadingOffsetY {
            contentOffset = .init(x: 0, y: reloadingOffsetY)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if contentOffset.y == reloadingOffsetY, let _ = reloadingBar, status.isReloadingAvailable {
            status = .reloading
            infiniteListDelegate?.infiniteListDidRequireReload(self)
        }
    }
}

/// Constants
private extension InfiniteList {
    
    /// System errors.
    static let cellNibError = "The nib file doesn't contain the customized InfiniteCell."
    static let cellError = "The cell is not an InfiniteCell."
    static let cellRegistrationError = "The cell has not been registered yet."
    static let emptyStateNibError = "The nib file doesn't contain a UIView for the empty state."
    static let emptyStateRegistrationError = "The empty state has not been registered yet."
    static let superviewError = "The list hasn't been moved to a superview."
    static let reloadingBarNibError = "The nib file doesn't contain a UIView for the reloading bar."
    static let reloadingBarRegistrationError = "The reloading bar hasn't been registered yet."
    static let loadingMoreCellNibError = "The nib file doesn't contain a UIView for the loading more bar."
    static let displayStatusError = "The items cannot be displayed under current status."
    static let registrationError = "The status other than initial doesn't allow registration."
    
    /// System warnings.
    static let emptyStateShowWarning = "The empty state has already been shown."
    static let emptyStateHideWarning = "The empty state has already been hidden."
    static let cellExpansionWarning = "The cell cannot be expanded."
    static let cellCollapsionWarning = "The cell cannot be collapsed."
    
    /// The default minimal page size.
    static let defaultPageSize = 10
}

import AdvancedFoundation
import UIKit
