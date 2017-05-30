extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        let viewController = storyboard!.instantiateViewController(withIdentifier: feature.viewControllerID)
        viewController.title = feature.rawValue
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

import UIKit
