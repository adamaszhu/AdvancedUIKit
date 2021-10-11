/// ToggleRow presents a switch item in the collection.
///
/// - version: 1.8.0
/// - date: 08/10/21
/// - author: Adamas
open class ToggleRow: LabelRow, ToggleRowType {

    public var didChangeValueAction: ((Bool) -> Void)?
    
    public var value: Bool = false {
        didSet {
            if oldValue != value {
                didChangeValueAction?(value)
                reloadAction?()
            }
        }
    }
}

/// The protocol of the toggle row
public protocol ToggleRowType: LabelRowType {

    /// The current value of the toggle.
    var value: Bool { get set }

    /// The action to be triggered when the value is changed.
    var didChangeValueAction: ((Bool) -> Void)? { get set }
}
