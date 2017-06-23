extension ListViewController: InfiniteListDelegate {
    
    private static let selectTitle = "Select"
    
    func infiniteList(_ infiniteList: InfiniteList, didSelectItem item: Any) {
        SystemMessageHelper.standard?.showInfo("\(item)", withTitle: ListViewController.selectTitle)
    }
    
}

import AdvancedUIKit
