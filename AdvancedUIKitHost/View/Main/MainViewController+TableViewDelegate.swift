extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        navigationController?.showViewController(withIdentifier: feature.viewControllerID, withInitialization: { (viewController) in
            viewController.title = feature.rawValue
        })
    }
    
}

import UIKit
