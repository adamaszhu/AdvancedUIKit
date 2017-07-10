final class ListViewController: UIViewController {
    
    fileprivate let emptyStateNibName = "EmptyState"
    fileprivate let reloadBarNibName = "ReloadBar"
    fileprivate let loadMoreBarNibName = "LoadMoreBar"
    fileprivate let selectTitle = "Select"
    
    @IBOutlet fileprivate weak var infiniteList: InfiniteList!
    
    fileprivate lazy var dataGenerator: DataGenerator = {
        let dataGenerator = DataGenerator()
        dataGenerator.delegate = self
        return dataGenerator
    }()
    fileprivate var isLoadingEmptyPage: Bool = false
    
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
        infiniteList.register(UINib(nibName: String(describing: LabelCell.self), bundle: nil), for: LabelCell.self)
        infiniteList.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), for: ImageCell.self)
        infiniteList.registerEmptyState(UINib(nibName: emptyStateNibName, bundle: nil))
        infiniteList.registerReloadBar(UINib(nibName: reloadBarNibName, bundle: nil))
        infiniteList.registerLoadMoreBar(UINib(nibName: loadMoreBarNibName, bundle: nil))
    }
    
}

extension ListViewController: InfiniteListDelegate {
    
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) {
        SystemMessageHelper.standard?.showInfo("\(item)", withTitle: selectTitle)
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
