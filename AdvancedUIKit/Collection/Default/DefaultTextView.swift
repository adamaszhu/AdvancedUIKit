/// DefaultTextView defines a text field view that can be used directly
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
public final class DefaultTextView: TextView<DefaultTextRow> {

    override public func initialize() {
        super.initialize()
        // TODO: Change the bundle to Bundle.module
        guard let view = UINib(nibName: String(describing: DefaultTextView.self),
                               bundle: .current)
                .instantiate(withOwner: self).first as? UIView else {
            Logger.standard.logError(Self.nibError)
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview()
    }
}

/// Constants
private extension DefaultTextView {

    /// System error.
    static let nibError = "The nib file is invalid."
}

import UIKit
import AdvancedFoundation
