/// ToggleView defines a view that has a toggle
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
open class ToggleView<Row: ToggleRowType>: LabelView<Row> {

    /// The toggle
    @IBOutlet public private(set) var `switch`: UISwitch! {
        didSet {
            `switch`.addTarget(self, action: #selector(changeValue), for: .primaryActionTriggered)
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
        self.row?.reloadAction = { [weak self] in
            guard let self = self,
                let row = self.row else {
                return
            }
            self.`switch`.isOn = row.value
        }
        self.row?.reloadAction?()
    }

    @IBAction func changeValue(_: Any) {
        row?.value = `switch`.isOn
    }
}

import UIKit
