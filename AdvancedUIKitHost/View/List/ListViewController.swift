final class ListViewController: UIViewController {
    
    fileprivate let emptyStateNibName = "EmptyState"
    fileprivate let reloadingBarNibName = "ReloadingBar"
    fileprivate let loadingMoreBarNibName = "LoadingMoreBar"
    fileprivate let selectionTitle = "Select"
    
    @IBOutlet fileprivate weak var infiniteList: InfiniteList!
    
    fileprivate var isLoadingEmptyPage: Bool = false
    fileprivate lazy var dataGenerator: DataGenerator = {
        let dataGenerator = DataGenerator()
        dataGenerator.delegate = self
        return dataGenerator
    }()
    
    @IBAction func reloadItems(_ sender: Any) {
        isLoadingEmptyPage = false
        infiniteList.startReloading()
    }
    
    @IBAction func clearItems(_ sender: Any) {
        isLoadingEmptyPage = true
        infiniteList.startReloading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteList.infiniteListDelegate = self
        infiniteList.register(LabelCell.self, with: UINib(nibName: String(describing: LabelCell.self), bundle: nil))
        infiniteList.register(ImageCell.self, with: UINib(nibName: String(describing: ImageCell.self), bundle: nil))
        infiniteList.registerEmptyState(UINib(nibName: emptyStateNibName, bundle: nil))
        infiniteList.registerReloadingBar(with: UINib(nibName: reloadingBarNibName, bundle: nil))
        infiniteList.registerLoadingMoreBar(with: UINib(nibName: loadingMoreBarNibName, bundle: nil))
    }
    
}

extension ListViewController: InfiniteListDelegate {
    
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) {
        SystemMessageHelper.standard?.showInfo("\(item)", withTitle: selectionTitle)
    }
    
    func infiniteListDidRequireReload(_ infiniteList: InfiniteList) {
        if isLoadingEmptyPage {
            dataGenerator.generateNoItems()
        } else {
            dataGenerator.generateItems(forPage: 0)
        }
    }
    
    func infiniteList(_ infiniteList: InfiniteList, didRequireLoadPage page: Int) {
        dataGenerator.generateItems(forPage: page)
    }
    
}

extension ListViewController: DataGeneratorDelegate {
    
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem], forPage page: Int) {
        if page == 0 {
            infiniteList.reload(items)
        } else {
            infiniteList.append(items)
        }
    }
    
}

import AdvancedUIKit
import UIKit
