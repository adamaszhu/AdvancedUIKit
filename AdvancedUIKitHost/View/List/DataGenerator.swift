protocol DataGeneratorDelegate: class {
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem])
}

final class DataGenerator {
    
    weak var delegate: DataGeneratorDelegate?
    var itemAmount = 0
    
    func generateItems(forPage page: Int) {
        var items = [InfiniteItem]()
        for index in page * DataGenerator.pageSize ..< (page + 1) * DataGenerator.pageSize {
            guard index <= itemAmount else {
                break
            }
            let cellType = index % DataGenerator.imageFilter != 1 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        dispatch(items)
    }
    
    private func dispatch(_ items: [InfiniteItem]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + DataGenerator.generationDelay) {
            self.delegate?.dataGenerator(self, didGenerate: items)
        }
    }
}

private extension DataGenerator {
    static let pageSize = 10
    static let generationDelay = 2.0
    static let imageFilter = 3
}

import AdvancedUIKit
import Foundation
