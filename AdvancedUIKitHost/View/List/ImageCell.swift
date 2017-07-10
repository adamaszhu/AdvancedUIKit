final class ImageCell: InfiniteCell {
    
    private let firstImageName = "ImageA"
    private let secondImageName = "ImageB"
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    
    override func render(_ item: Any) {
        label.text = "\(item)"
        if let number = item as? Int {
            let imageName = number % 2 == 0 ? firstImageName : secondImageName
            icon.image = UIImage(named: imageName)
        }
    }
    
}

import AdvancedUIKit
import UIKit
