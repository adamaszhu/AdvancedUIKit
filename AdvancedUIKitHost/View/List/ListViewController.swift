class ListViewController: UIViewController {
    
    private let emptyStateNib = "EmptyState"
    
    @IBOutlet weak var infiniteList: InfiniteList!
    
    var items: Array<InfiniteItem> {
        return [InfiniteItem(item: 0, type: LabelCell.self),
        InfiniteItem(item: 1, type: ImageCell.self),
        InfiniteItem(item: 2, type: LabelCell.self),
        InfiniteItem(item: 3, type: ImageCell.self),
        InfiniteItem(item: 4, type: ImageCell.self),
        InfiniteItem(item: 5, type: LabelCell.self),
        InfiniteItem(item: 6, type: LabelCell.self),
        InfiniteItem(item: 7, type: ImageCell.self),
        InfiniteItem(item: 8, type: ImageCell.self),
        InfiniteItem(item: 9, type: LabelCell.self)]
    }
    
    @IBAction func reloadItems(_ sender: Any) {
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
        infiniteList.reload([])
    }
    
}

import AdvancedUIKit
import UIKit
