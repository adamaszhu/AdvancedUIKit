final class CollectionViewController: UIViewController {

    @IBOutlet private var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let rows: [RowPresentable] = [DefaultLabelRow(title: "Default Label")]
        rows.map { $0.view }
            .forEach(stackView.addArrangedSubview)
    }
}

import AdvancedUIKit
import UIKit
