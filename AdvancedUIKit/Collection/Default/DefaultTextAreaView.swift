/// DefaultTextAreaView defines a text area view that can be used directly
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
public final class DefaultTextAreaView: TextAreaView<DefaultTextAreaRow> {
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    private func initialize() {
        // TODO: Change the bundle to Bundle.module
        guard let view = UINib(nibName: String(describing: DefaultTextAreaView.self),
                               bundle: .current)
                .instantiate(withOwner: self).first as? UIView else {
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview()
    }
}

import UIKit
