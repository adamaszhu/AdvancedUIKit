#if !os(macOS)
/// SearchBar+Accessable add additional support for extracting sub components.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 08/05/2019
public extension UISearchBar {
    
    /// The text field
    var textField: UITextField? {
        return value(forKey: Self.textFieldKey) as? UITextField
    }
}

/// Constants
private extension UISearchBar {
    static let textFieldKey = "searchField"
}

import UIKit
#endif
