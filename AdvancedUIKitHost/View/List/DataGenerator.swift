protocol DataGeneratorDelegate {
    
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem], forPage page: Int)
    
}

final class DataGenerator {
    
    private let itemAmount = 55
    private let pageSize = 10
    private let generationDelay = 2.0
    
    var delegate: DataGeneratorDelegate?
    
    func generateItems(forPage page: Int) {
        var items = [InfiniteItem]()
        for index in page * pageSize ..< (page + 1) * pageSize {
            guard index <= itemAmount else {
                break
            }
            let cellType = index % 3 != 2 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + generationDelay) {
            self.delegate?.dataGenerator(self, didGenerate: items, forPage: page)
        }
    }
    
    func generateNoItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + generationDelay) {
            self.delegate?.dataGenerator(self, didGenerate: [], forPage: 0)
        }
    }
    
}

import AdvancedUIKit
import Foundation
