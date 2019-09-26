/// Checkbox provides a customized checkbox
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/08/2019
open class Checkbox: UIButton {
    
    /// Switch the status of the checkbox
    @objc func switchStatus() {
        isSelected = !isSelected
    }
    
    /// Add the click event to the button
    private func addClickEvent() {
        addTarget(self, action: #selector(switchStatus), for: .touchUpInside)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addClickEvent()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addClickEvent()
    }
}

import UIKit
