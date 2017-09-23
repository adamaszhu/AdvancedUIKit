final class ListViewController: UIViewController {
    
    let emptyStateNibName = "EmptyState"
    let reloadingBarNibName = "ReloadingBar"
    let loadingMoreBarNibName = "LoadingMoreBar"
    let selectionTitle = "Select"
    let deletionTitle = "Delete"
    let defaultItemAmount = 55
    let emptyItemAmount = -1
    
    @IBOutlet weak var infiniteList: InfiniteList!
    
    lazy var dataGenerator: DataGenerator = {
        let dataGenerator = DataGenerator()
        dataGenerator.delegate = self
        dataGenerator.itemAmount = self.defaultItemAmount
        return dataGenerator
    }()
    
    @IBAction func reloadItems(_ sender: Any) {
        dataGenerator.itemAmount = defaultItemAmount
        infiniteList.startReloading()
    }
    
    @IBAction func clearItems(_ sender: Any) {
        dataGenerator.itemAmount = emptyItemAmount
        infiniteList.startReloading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteList.isEditable = true
        infiniteList.infiniteListDelegate = self
        infiniteList.register(LabelCell.self, with: UINib(nibName: String(describing: LabelCell.self), bundle: nil))
        infiniteList.register(ImageCell.self, with: UINib(nibName: String(describing: ImageCell.self), bundle: nil))
        infiniteList.registerEmptyState(with: UINib(nibName: emptyStateNibName, bundle: nil))
        infiniteList.registerReloadingBar(with: UINib(nibName: reloadingBarNibName, bundle: nil))
        infiniteList.registerLoadingMoreBar(with: UINib(nibName: loadingMoreBarNibName, bundle: nil))
    }
    
}

import AdvancedUIKit
import UIKit
