/// KeyboardHelper+UISearchBarDelegate implements the action on a search bar.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 05/06/2017
extension KeyboardHelper: UISearchBarDelegate {
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        changeInputView(searchBar)
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        finishInput(onView: searchBar)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyboardHelperDelegate?.keyboardHelper(self, didChangeContentOf: searchBar)
    }
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let keyboardHelperDelegate = keyboardHelperDelegate else {
            return true
        }
        var newContent: String
        if let originalText = searchBar.text as NSString? {
            newContent = originalText.replacingCharacters(in: range, with: text)
        } else {
            newContent = text
        }
        return keyboardHelperDelegate.keyboardHelper(self, shouldChangeContentOf: searchBar, toContent: newContent)
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        keyboardHelperDelegate?.keyboardHelper(self, willEditOn: searchBar)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        keyboardHelperDelegate?.keyboardHelper(self, didEditOn: searchBar)
    }
    
}

import UIKit
