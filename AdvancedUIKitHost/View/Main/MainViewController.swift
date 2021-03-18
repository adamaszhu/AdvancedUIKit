final class MainViewController: UIViewController {
    
    let features: [Feature] = [.actionSheet, .application, .audio, .button, .device, .image, .keyboard, .label, .list, .localization, .location, .map, .message, .navigation, .notification, .picker, .textField, .view]
    
    @IBOutlet private weak var featureTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
    }
}

extension MainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeatureTableCell.self)) as? FeatureTableCell else {
            return UITableViewCell()
        }
        cell.render(for: features[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        let featureName = feature.rawValue.replacingOccurrences(of: String.space, with: String.empty)
        navigationController?.showInitialViewController(ofStoryboard: featureName, initialization: { viewController in
            viewController.title = feature.rawValue
        })
    }
}
import UIKit
import AdvancedFoundation
