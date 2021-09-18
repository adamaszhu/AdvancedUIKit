protocol DataGeneratorDelegate: AnyObject {
    func dataGenerator(_ dataGenerator: DataGenerator, didGenerate items: [InfiniteItem])
}

final class DataGenerator {
    
    weak var delegate: DataGeneratorDelegate?
    var itemAmount = 0
    
    func generateItems(forPage page: Int) {
        var items = [InfiniteItem]()
        for index in page * Self.pageSize ..< (page + 1) * Self.pageSize {
            guard index <= itemAmount else {
                break
            }
            let cellType = index % Self.imageFilter != 1 ? LabelCell.self : ImageCell.self
            items.append(InfiniteItem(item: index, type: cellType))
        }
        dispatch(items)
    }
    
    private func dispatch(_ items: [InfiniteItem]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Self.generationDelay) {
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
