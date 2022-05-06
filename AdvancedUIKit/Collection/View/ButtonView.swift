/// ButtonView defines a view that has a button
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
open class ButtonView<Row: ButtonRowType>: View<Row> {

    /// The button
    @IBOutlet public private(set) var button: UIButton! {
        didSet {
            button?.addTarget(self, action: #selector(tap), for: .primaryActionTriggered)
        }
    }

    open override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
        button.setTitle(row.title, for: .normal)
        button.setImage(row.icon, for: .normal)

        self.row?.reloadAction = { [weak self] in
            guard let self = self,
                let row = self.row else {
                return
            }
            self.button.isEnabled = row.isEnabled
        }
        self.row?.reloadAction?()
    }

    @IBAction func tap(_: Any) {
        row?.didClickAction?()
    }
}

import UIKit
