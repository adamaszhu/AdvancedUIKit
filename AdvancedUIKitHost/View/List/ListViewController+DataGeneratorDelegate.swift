extension ListViewController: DataGeneratorDelegate {
    
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem]) {
        infiniteList.display(items)
    }
    
}

import AdvancedUIKit
