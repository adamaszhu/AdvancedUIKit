/// DefaultToggleView defines a toggle view that can be used directly
///
/// - version: 1.8.0
/// - date: 04/05/22
/// - author: Adamas
public final class DefaultToggleView: ToggleView<DefaultToggleRow> {
    
    public override func initialize() {
        super.initialize()
        // TODO: Change the bundle to Bundle.module
        guard let view = UINib(nibName: String(describing: DefaultToggleView.self),
                               bundle: .current)
                .instantiate(withOwner: self).first as? UIView else {
            return
        }
        addSubview(view)
        view.pinEdgesToSuperview()
    }
}

import UIKit
