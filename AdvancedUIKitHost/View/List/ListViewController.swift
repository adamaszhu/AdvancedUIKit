final class ListViewController: UIViewController {
    
    fileprivate let emptyStateNib = "EmptyState"
    fileprivate let reloadBar = "ReloadBar"
    fileprivate let loadMoreBar = "LoadMoreBar"
    fileprivate let selectTitle = "Select"
    
    fileprivate lazy var dataGenerator: DataGenerator = DataGenerator()
    
    @IBOutlet fileprivate weak var infiniteList: InfiniteList!
    
    @IBAction func reloadItems(_ sender: Any) {
        let items = dataGenerator.generateFirstPage()
        infiniteList.reload(items)
    }
    
    @IBAction func clearItems(_ sender: Any) {
        infiniteList.reload([])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteList.infiniteListDelegate = self
        infiniteList.register(UINib(nibName: String(describing: LabelCell.self), bundle: nil), for: LabelCell.self)
        infiniteList.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), for: ImageCell.self)
        infiniteList.registerEmptyState(UINib(nibName: emptyStateNib, bundle: nil))
        infiniteList.registerReloadBar(UINib(nibName: reloadBar, bundle: nil))
        infiniteList.registerLoadMoreBar(UINib(nibName: loadMoreBar, bundle: nil))
    }
    
}

extension ListViewController: InfiniteListDelegate {
    
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) {
        SystemMessageHelper.standard?.showInfo("\(item)", withTitle: selectTitle)
    }
    
}

import AdvancedUIKit
import UIKit
