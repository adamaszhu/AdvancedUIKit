#if !os(macOS)
/// PageView is a customized page view.
///
/// - author: Adamas
/// - version: 1.5.0
/// - date: 07/08/2019
public class PageView: UIScrollView {
    
    /// The delegate
    public weak var pageViewDelegate: PageViewDelegate?
    
    /// The page controller.
    private (set) var pageControl: UIPageControl = UIPageControl()
    
    /// Whether the paging point should be shown or not.
    public var shouldShowPageControl: Bool {
        set { pageControl.isHidden = !newValue }
        get { pageControl.isHidden }
    }
    
    /// The index of the current page.
    public var currentPageIndex: Int {
        get { pageControl.currentPage }
        set { pageControl.currentPage = newValue }
    }
    
    /// The number of pages in the controller.
    public var numberOfPages: Int { pageControl.numberOfPages }
    
    /// The current page presented.
    public var currentPage: UIView? {
        guard let subview = subviews.element(atIndex: currentPageIndex) else {
            Logger.standard.logError(Self.pageIndexError)
            return nil
        }
        return subview
    }
    
    /// The buttom bargin of the page control.
    public var pageControlButtomMargin: CGFloat {
        set {
            let x = (frame.width - pageControl.frame.width) / 2
            let y = frame.height - pageControl.frame.height - newValue
            pageControl.frame.origin = CGPoint(x: x, y: y)
        }
        get {
            frame.height - pageControl.frame.origin.y - pageControl.frame.height
        }
    }
    
    /// Add a new view.
    ///
    /// - Parameter view: The view to be added.
    public func add(_ view: UIView) {
        pageControl.numberOfPages = pageControl.numberOfPages + 1
        let x = CGFloat(pageControl.numberOfPages - 1) * frame.width
        view.frame = CGRect(x: x, y: 0, width: frame.width, height: frame.height)
        addSubview(view)
        contentSize = CGSize(width: view.frame.origin.x + view.frame.width, height: view.frame.height)
    }
    
    /// Replace a view.
    ///
    /// - Parameters:
    ///   - view: The view to be replaced.
    ///   - index: The index of the replaced view.
    public func replace(_ view: UIView, atIndex index: Int) {
        guard let subview = subviews.element(atIndex: index) else {
            Logger.standard.logError(Self.pageIndexError)
            return
        }
        view.frame = subview.frame
        subview.removeFromSuperview()
        insertSubview(view, at: index)
    }
    
    /// Remove a view.
    ///
    /// - Parameter index: The index of the view to be removed.
    public func removeView(atIndex index: Int) {
        guard let subview = subviews.element(atIndex: index) else {
            Logger.standard.logError(Self.pageIndexError)
            return
        }
        if index <= currentPageIndex, currentPageIndex != 0  {
            // While removing the page before current page.
            switchToPage(withIndex: currentPageIndex - 1, withAnimation: false)
        }
        // Adjust all views after the removed view.
        for laterIndex in index + 1 ..< pageControl.numberOfPages {
            guard let subview = subviews.element(atIndex: laterIndex) else {
                continue
            }
            subview.frame.origin = CGPoint(x: subview.frame.origin.x - frame.width, y: 0)
        }
        pageControl.numberOfPages = pageControl.numberOfPages - 1
        subview.removeFromSuperview()
        contentSize = CGSize(width: CGFloat(pageControl.numberOfPages) * frame.width, height: frame.height)
    }
    
    /// Remove all sub views.
    public func removeAllViews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        contentSize = CGSize(width: 0, height: frame.height)
        pageControl.numberOfPages = 0
    }
    
    /// Switch to next page.
    @objc public func switchToNextPage() {
        guard currentPageIndex != pageControl.numberOfPages - 1 else {
            Logger.standard.logWarning(Self.lastPageWarning)
            return
        }
        switchToPage(withIndex: currentPageIndex + 1)
    }
    
    /// Switch to previous page.
    @objc public func switchToPreviousPage() {
        guard currentPageIndex != 0 else {
            Logger.standard.logWarning(Self.firstPageWarning)
            return
        }
        switchToPage(withIndex: currentPageIndex - 1)
    }
    
    /// Switch to a specific news page.
    /// 
    /// - Parameters:
    ///   - index: The page index of the news.
    ///   - shouldAnimate: Whether the animation should be allowed or not.
    public func switchToPage(withIndex index: Int, withAnimation shouldAnimate: Bool = true) {
        guard 0 ..< pageControl.numberOfPages ~= index else {
            Logger.standard.logError(Self.pageIndexError)
            return
        }
        pageControl.currentPage = index
        pageViewDelegate?.pageView(self, didChangePageIndex: index)
        guard shouldAnimate else {
            contentOffset = CGPoint(x: CGFloat(index) * frame.width, y: 0)
            return
        }
        animateChange({ [weak self] in
            guard let self = self else {
                return
            }
            self.contentOffset = CGPoint(x: CGFloat(index) * self.frame.width, y: 0)
        })
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shouldShowPageControl = true
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = UIColor.clear
        pageControl.numberOfPages = subviews.count
        delegate = self
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if pageControlButtomMargin == frame.height {
            // The default margin will be used if the margin hasn't been settled.
            pageControlButtomMargin = Self.defaultPageControlButtomMargin
        }
        pageControl.frame = CGRect(x: (frame.width - pageControl.frame.width) / 2, y: frame.height - pageControl.frame.height - pageControlButtomMargin, width: pageControl.frame.width, height: pageControl.frame.height)
        // Refresh all subviews
        for index in 0 ..< subviews.count {
            subviews[index].frame = CGRect(x: CGFloat(index) * frame.width, y: 0, width: frame.width, height: frame.height)
        }
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = superview, pageControl.superview == nil else {
            return
        }
        superview.addSubview(pageControl)
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        pageControl.removeFromSuperview()
    }
}

/// UIScrollViewDelegate
extension PageView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(contentOffset.x / frame.width))
        if pageIndex != currentPageIndex {
            pageControl.currentPage = pageIndex
            pageViewDelegate?.pageView(self, didChangePageIndex: pageIndex)
        }
    }
}

/// Constants
private extension PageView {
    
    /// The default buttom margin of the page control.
    static let defaultPageControlButtomMargin: CGFloat = 20
    
    /// System error.
    static let pageIndexError = "The page does not exist."
    
    /// System warning.
    static let firstPageWarning = "The page is the first page."
    static let lastPageWarning = "The page is the last page."
}

import AdvancedFoundation
import UIKit
#endif
