protocol DataGeneratorDelegate {
    
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem])
    
}

final class DataGenerator {
    
    private let pageSize = 10
    private let generationDelay = 2.0
    
    var delegate: DataGeneratorDelegate?
    var itemAmount = 0
    
    func generateItems(forPage page: Int) {
        var items = [InfiniteItem]()
        for index in page * pageSize ..< (page + 1) * pageSize {
            guard index <= itemAmount else {
                break
            }
            let cellType = index % 3 != 2 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        dispatch(items)
    }
    
    private func dispatch(_ items: [InfiniteItem]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + generationDelay) {
            self.delegate?.dataGenerator(self, didGenerate: items)
        }
    }
    
}

import AdvancedUIKit
import Foundation
