final class CollectionViewController: UIViewController {

    @IBOutlet private var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRow = DefaultTapRow(title: "Default Tap Row")
        tapRow.didTapAction = {
            SystemMessageHelper()?.showInfo("Tap")
        }
        let rows: [RowPresentable] = [DefaultLabelRow(title: "Default Label Row"),
                                      tapRow]
        rows.map { $0.view }
            .forEach(stackView.addArrangedSubview)
    }
}

import AdvancedUIKit
import UIKit
