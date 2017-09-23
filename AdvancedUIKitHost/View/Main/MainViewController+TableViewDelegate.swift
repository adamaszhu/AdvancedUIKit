extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        let featureName = feature.rawValue.replacingOccurrences(of: " ", with: "")
        navigationController?.showInitialViewController(ofStoryboard: featureName, withInitialization: { viewController in
            viewController.title = feature.rawValue
        })
    }
    
}

import UIKit
