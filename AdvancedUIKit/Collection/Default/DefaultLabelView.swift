/// DefaultLabelView defines a label view that can be used directly
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public final class DefaultLabelView: LabelView<DefaultLabelRow> {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    /// Initialize the UI
    private func initialize() {
        // TODO: Change the bundle to Bundle.module
        guard let view = UINib(nibName: String(describing: DefaultLabelView.self),
                               bundle: Bundle(for: DefaultLabelView.self))
                .instantiate(withOwner: self).first as? UIView else {
            Logger.standard.logError(Self.nibError)
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview()
    }
}

/// Constants
private extension DefaultLabelView {

    /// System error.
    static let nibError = "The nib file is invalid."
}

import AdvancedFoundation
import UIKit
