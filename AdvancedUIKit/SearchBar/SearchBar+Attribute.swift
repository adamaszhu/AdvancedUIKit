/// SearchBar+Attribute add additional support for extracting sub components.
///
/// - author: Adamas
/// - version: 1.3.0
/// - date: 06/07/2018
public extension UISearchBar {
    
    /// Keys
    private static let textFieldKey = "searchField"
    
    /// The text field
    var textField: UITextField? {
        return value(forKey: UISearchBar.textFieldKey) as? UITextField
    }
    
}


import UIKit
