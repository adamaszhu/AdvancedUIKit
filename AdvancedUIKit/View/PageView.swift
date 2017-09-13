/// PageView is a customized page view.
///
/// - author: Adamas
/// - version: 1.0.0
/// - date: 11/06/2017
public class PageView: UIScrollView {
    
    /// The default buttom margin of the page control.
    private static let defaultPageControlButtomMargin = CGFloat(20)
    
    /// System error.
    private static let pageIndexError = "The page does not exist."
    
    /// System warning.
    private static let firstPageWarning = "The page is the first page."
    private static let lastPageWarning = "The page is the last page."
    
    /// The page controller.
    var pageControl: UIPageControl
    
    /// Whether the paging point should be shown or not.
    public var shouldShowPageControl: Bool {
        set {
            pageControl.isHidden = !newValue
        }
        get {
            return pageControl.isHidden
        }
    }
    
    /// The index of the current page.
    public var currentPageIndex: Int {
        return pageControl.currentPage
    }
    
    /// The current page presented.
    public var currentPage: UIView? {
        guard 0 ..< pageControl.numberOfPages ~= currentPageIndex else {
            Logger.standard.log(error: PageView.pageIndexError)
            return nil
        }
        return subviews[currentPageIndex]
    }
    
    /// The buttom bargin of the page control.
    public var pageControlButtomMargin: CGFloat {
        set {
            pageControl.frame.origin = .init(x: (frame.width - pageControl.frame.width) / 2, y: frame.height - pageControl.frame.height - newValue)
        }
        get {
            return frame.height - pageControl.frame.origin.y - pageControl.frame.height
        }
    }
    
    /// Add a new view.
    ///
    /// - Parameter view: The view to be added.
    public func add(_ view: UIView) {
        pageControl.numberOfPages = pageControl.numberOfPages + 1
        view.frame = .init(x: CGFloat(pageControl.numberOfPages - 1) * frame.width, y: 0, width: frame.width, height: frame.height)
        addSubview(view)
        contentSize = .init(width: view.frame.origin.x + view.frame.width, height: view.frame.height)
    }
    
    /// Replace a view.
    ///
    /// - Parameters:
    ///   - view: The view to be replaced.
    ///   - index: The index of the replaced view.
    public func replace(_ view: UIView, atIndex index: Int) {
        guard 0 ..< pageControl.numberOfPages ~= index else {
            Logger.standard.log(error: PageView.pageIndexError)
            return
        }
        view.frame = subviews[index].frame
        subviews[index].removeFromSuperview()
        insertSubview(view, at: index)
    }
    
    /// Remove a view.
    ///
    /// - Parameter index: The index of the view to be removed.
    public func removeView(atIndex index: Int) {
        // TODO: Add animation for the removing action.
        guard 0 ..< pageControl.numberOfPages ~= index else {
            Logger.standard.log(error: PageView.pageIndexError)
            return
        }
        if index <= currentPageIndex, currentPageIndex != 0  {
            // While removing the page before current page.
            switchToPage(withIndex: currentPageIndex - 1, withAnimation: false)
        }
        // Adjust all views after the removed view.
        for laterIndex in index + 1 ..< pageControl.numberOfPages {
            subviews[laterIndex].frame.origin = CGPoint(x: subviews[laterIndex].frame.origin.x - frame.width, y: 0)
        }
        pageControl.numberOfPages = pageControl.numberOfPages - 1
        subviews[index].removeFromSuperview()
        contentSize = .init(width: CGFloat(pageControl.numberOfPages) * frame.width, height: frame.height)
    }
    
    /// Remove all sub views.
    public func removeAllViews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        contentSize = .init(width: 0, height: frame.height)
        pageControl.numberOfPages = 0
    }
    
    /// Switch to next page.
    public func switchToNextPage() {
        guard currentPageIndex != pageControl.numberOfPages - 1 else {
            Logger.standard.log(warning: PageView.lastPageWarning)
            return
        }
        switchToPage(withIndex: currentPageIndex + 1)
    }
    
    /// Switch to previous page.
    public func switchToPreviousPage() {
        guard currentPageIndex != 0 else {
            Logger.standard.log(warning: PageView.firstPageWarning)
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
            Logger.standard.log(error: PageView.pageIndexError)
            return
        }
        pageControl.currentPage = index
        guard shouldAnimate else {
            contentOffset = .init(x: CGFloat(index) * frame.width, y: 0)
            return
        }
        animate(withChange: { [unowned self] _ in
            self.contentOffset = .init(x: CGFloat(index) * self.frame.width, y: 0)
        })
    }
    
    public required init?(coder aDecoder: NSCoder) {
        pageControl = .init()
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
            pageControlButtomMargin = PageView.defaultPageControlButtomMargin
        }
        pageControl.frame = .init(x: (frame.width - pageControl.frame.width) / 2, y: frame.height - pageControl.frame.height - pageControlButtomMargin, width: pageControl.frame.width, height: pageControl.frame.height)
        // Refresh all subviews
        for index in 0 ..< subviews.count {
            subviews[index].frame = .init(x: CGFloat(index) * frame.width, y: 0, width: frame.width, height: frame.height)
        }
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = superview else {
            return
        }
        guard pageControl.superview == nil else {
            return
        }
        superview.addSubview(pageControl)
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        pageControl.removeFromSuperview()
    }
    
}

import UIKit
