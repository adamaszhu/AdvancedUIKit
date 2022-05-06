/// TapView defines the basic of a custom tappable view
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class TapView<Row: TapRowType>: LabelView<Row> {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Initialize the view
    private func initialize() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGestureRecognizer)
    }

    open override func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        super.configure(with: row)
    }

    /// Action to trigger when the view is tapped.
    /// - Parameter :  The view that triggers the event
    @IBAction public func tap(_: Any) {
        guard row?.isEnabled == true else {
            return
        }
        row?.didTapAction?()
    }
}

import UIKit
