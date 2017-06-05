extension MainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeatureTableCell.self)) as! FeatureTableCell
        cell.render(for: features[indexPath.row])
        return cell
    }
    
}

import UIKit
