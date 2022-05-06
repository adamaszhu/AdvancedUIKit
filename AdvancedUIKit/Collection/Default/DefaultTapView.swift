/// DefaultTapView defines a label view that can be used directly
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
public final class DefaultTapView: TapView<DefaultTapRow> {

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
        guard let view = UINib(nibName: String(describing: DefaultTapView.self),
                               bundle: Bundle(for: DefaultTapView.self))
                .instantiate(withOwner: self).first as? UIView else {
            Logger.standard.logError(Self.nibError)
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview()
    }
}

/// Constants
private extension DefaultTapView {

    /// System error.
    static let nibError = "The nib file is invalid."
}

import AdvancedFoundation
import UIKit
