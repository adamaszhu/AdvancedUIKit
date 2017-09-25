/// Checkbox provides a customized checkbox
///
/// - author: Adamas
/// - version: 1.1.0
/// - date: 25/09/2017
final public class Checkbox: UIButton {
    
    /// Switch the status of the checkbox
    func switchStatus() {
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
