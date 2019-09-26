final class FeatureTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func render(for feature: Feature) {
        nameLabel.text = feature.rawValue
    }
}

import UIKit
