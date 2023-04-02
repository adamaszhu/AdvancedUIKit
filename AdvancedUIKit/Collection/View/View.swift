/// View defines the basic of a custom view
///
/// - version: 1.8.0
/// - date: 11/10/21
/// - author: Adamas
open class View<Row: RowType>: UIView, RowConfigurable {
    
    /// The title label on the view
    @IBOutlet public private(set) var titleLabel: UILabel?
    
    /// The main image on the view
    @IBOutlet public private(set) var iconImageView: UIImageView?
    
    /// The row of the view
    public private(set) var row: Row?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// Initialize the UI
    open func initialize() {
        // Any actual view can override this method to initialize the UI
    }
    
    /// Configure the view with a row
    /// - Parameter row: The row of the view
    open func configure(with row: RowType) {
        guard let row = row as? Row else {
            let rowError = String(format: Self.rowErrorPattern,
                                  String(describing: Row.self),
                                  String(describing: row))
            fatalError(rowError)
        }
        self.row = row
        titleLabel?.text = row.title
        iconImageView?.image = row.icon
        iconImageView?.isHidden = row.icon == nil
        iconImageView?.tintColor = titleLabel?.textColor
        isHidden = row.isHidden
    }
}

/// Constants
extension View {

    /// Error
    static var rowErrorPattern: String { "Expect row type as %@ got %@" }
}

import UIKit
