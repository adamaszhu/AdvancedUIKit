class ListViewController: UIViewController {
    
    private let emptyStateNib = "EmptyState"
    private let reloadBar = "ReloadBar"
    private let pageSize = 10
    
    @IBOutlet weak var infiniteList: InfiniteList!
    
    private var pageIndex: Int!
    
    @IBAction func reloadItems(_ sender: Any) {
        pageIndex = 0
        infiniteList.reload(generateItem(forPage: 0))
    }
    
    @IBAction func clearItems(_ sender: Any) {
        infiniteList.reload([])
    }
    
    func generateItem(forPage page: Int) -> Array<InfiniteItem> {
        var items = Array<InfiniteItem>()
        for index in page * pageSize ..< (page + 1) * pageSize {
            let cellType = index % 3 != 2 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteList.infiniteListDelegate = self
        infiniteList.register(UINib(nibName: String(describing: LabelCell.self), bundle: nil), for: LabelCell.self)
        infiniteList.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), for: ImageCell.self)
        infiniteList.registerEmptyState(UINib(nibName: emptyStateNib, bundle: nil))
        infiniteList.registerReloadBar(UINib(nibName: reloadBar, bundle: nil))
        infiniteList.reload([])
    }
    
}

import AdvancedUIKit
import UIKit
