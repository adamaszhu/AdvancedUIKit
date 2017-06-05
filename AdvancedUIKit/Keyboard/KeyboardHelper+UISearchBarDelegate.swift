/**
 * KeyboardHelper+UISearchBarDelegate implements the action on a search bar.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 05/06/2017
 */
extension KeyboardHelper: UISearchBarDelegate {
    
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
    //        changeInputView(searchBar)
    //        return true
    //    }
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //        finishInput(onView: searchBar)
    //    }
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    //        if (keyboardHelperDelegate != nil) && keyboardHelperDelegate!.respondsToSelector(#selector(keyboardHelperDelegate!.keyboardHelperShouldChangeContent(_:ofInputView:toContent:))) {
    //            let newContent = (searchBar.text! as NSString).stringByReplacingCharactersInRange(range, withString: text)
    //            return keyboardHelperDelegate!.keyboardHelperShouldChangeContent!(self, ofInputView: searchBar, toContent: newContent)
    //        }
    //        return true
    //    }
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    //        keyboardHelperDelegate?.keyboardHelperDidChangeContent?(self, ofInputView: searchBar)
    //    }
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    //        keyboardHelperDelegate?.keyboardHelperWillEdit?(self, onInputView: searchBar)
    //    }
    //
    //    /**
    //     * - version: 0.0.3
    //     * - date: 16/10/2016
    //     */
    //    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    //        keyboardHelperDelegate?.keyboardHelperDidEdit?(self, onInputView: searchBar)
    //    }
}

import UIKit
