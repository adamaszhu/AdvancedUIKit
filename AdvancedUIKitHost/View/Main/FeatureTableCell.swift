final class FeatureTableCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    func render(for feature: Feature) {
        nameLabel.text = feature.rawValue
    }
    
}

import UIKit
