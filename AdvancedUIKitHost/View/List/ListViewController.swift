final class ListViewController: UIViewController {
    
    private let emptyStateNib = "EmptyState"
    private let reloadBar = "ReloadBar"
    private let loadMoreBar = "LoadMoreBar"
    
    private lazy var dataGenerator: DataGenerator = DataGenerator()
    
    @IBOutlet private weak var infiniteList: InfiniteList!
    
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

import AdvancedUIKit
import UIKit
