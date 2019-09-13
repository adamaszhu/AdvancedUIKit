final class ListViewController: UIViewController {
    
    private let messageHelper: SystemMessageHelper? = SystemMessageHelper()
    
    @IBOutlet private weak var infiniteList: InfiniteList!
    
    private lazy var dataGenerator: DataGenerator = {
        let dataGenerator = DataGenerator()
        dataGenerator.delegate = self
        dataGenerator.itemAmount = ListViewController.defaultItemAmount
        return dataGenerator
    }()
    
    @IBAction func reloadItems(_ sender: Any) {
        dataGenerator.itemAmount = ListViewController.defaultItemAmount
        infiniteList.startReloading()
    }
    
    @IBAction func clearItems(_ sender: Any) {
        dataGenerator.itemAmount = ListViewController.emptyItemAmount
        infiniteList.startReloading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteList.isEditable = true
        infiniteList.infiniteListDelegate = self
        infiniteList.register(LabelCell.self, with: UINib(nibName: String(describing: LabelCell.self), bundle: nil))
        infiniteList.register(ImageCell.self, with: UINib(nibName: String(describing: ImageCell.self), bundle: nil))
        infiniteList.registerEmptyState(with: UINib(nibName: ListViewController.emptyStateNibName, bundle: nil))
        infiniteList.registerReloadingBar(with: UINib(nibName: ListViewController.reloadingBarNibName, bundle: nil))
        infiniteList.registerLoadingMoreCell(with: UINib(nibName: ListViewController.loadingMoreBarNibName, bundle: nil))
    }
}

extension ListViewController: InfiniteListDelegate {
    
    func infiniteList(_ infiniteList: InfiniteList, didDeleteItem item: Any) {
        messageHelper?.showInfo("\(item)", withTitle: ListViewController.deletionTitle)
    }
    
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) {
        messageHelper?.showInfo("\(item)", withTitle: ListViewController.selectionTitle)
    }
    
    func infiniteListDidRequireReload(_ infiniteList: InfiniteList) {
        dataGenerator.generateItems(forPage: 0)
    }
    
    func infiniteList(_ infiniteList: InfiniteList, didRequireLoadPage page: Int) {
        dataGenerator.generateItems(forPage: page)
    }
}

extension ListViewController: DataGeneratorDelegate {
    
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem]) {
        infiniteList.display(items)
    }
}

private extension ListViewController {
    static let emptyStateNibName = "EmptyState"
    static let reloadingBarNibName = "ReloadingBar"
    static let loadingMoreBarNibName = "LoadingMoreBar"
    static let selectionTitle = "Select"
    static let deletionTitle = "Delete"
    static let defaultItemAmount = 55
    static let emptyItemAmount = -1
}

import AdvancedUIKit
import UIKit
