/**
 * PageView is a customized page view.
 * - author: Adamas
 * - version: 1.0.0
 * - date: 11/06/2017
 */
public class PageView: UIScrollView {
    
    /**
 * The default buttom margin of the page control.
 */
    private static let defaultPageControlButtomMargin = CGFloat(20)
    
    /**
     * System error.
     */
    private static let pageExistanceError = "The page does not exist."
    
    /**
     * The page controller.
     */
    private var pageControl: UIPageControl
    
    /**
     * Whether the paging point should be shown or not.
     */
    public var shouldShowPageControl: Bool {
        set {
            pageControl.isHidden = !newValue
        }
        get {
            return pageControl.isHidden
        }
    }
    
    /**
     * The index of the current page.
     */
    public var currentPageIndex: Int {
        return pageControl.currentPage
    }
    
    /**
     * The buttom bargin of the page control.
     */
    public var pageControlButtomMargin: CGFloat {
        set {
            pageControl.frame.origin = CGPoint(x: (frame.width - pageControl.frame.width) / 2, y: frame.height - pageControl.frame.height - newValue)
        }
        get {
            return frame.height - pageControl.frame.origin.y - pageControl.frame.height
        }
    }
    
    /**
     * Add a new view.
     * - parameter view: The view to be added.
     */
    public func add(_ view: UIView) {
        pageControl.numberOfPages = pageControl.numberOfPages + 1
        view.frame = CGRect(x: CGFloat(pageControl.numberOfPages - 1) * frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(view)
        contentSize = CGSize(width: view.frame.origin.x + view.frame.width, height: view.frame.height)
    }
    
    /**
     * Replace a view.
     * - parameter view: The view to be replaced.
     * - parameter index: The index of the replaced view.
     */
    public func replace(_ view: UIView, atIndex index: Int) {
        if (index < 0) || (index >= subviews.count) {
            Logger.standard.logError(PageView.pageExistanceError)
            return
        }
        view.frame = subviews[index].frame
        subviews[index].removeFromSuperview()
        insertSubview(view, at: index)
    }
    
    /**
     * Remove a view.
     * - parameter index: The index of the view to be removed.
     */
    public func removeView(atIndex index: Int) {
        //        if (index < 0) || (index >= subviews.count) {
        //            Logger.standard.logError(PageView.pageExistanceError)
        //            return
        //        }
        //        if
        //        let view = subviews[index]
        //        view.removeFromSuperview()
        //        for index in index + 1 ..< subviews.count {
        //
        //        }
        //        pageControl.numberOfPages = pageControl.numberOfPages - 1
    }
    //
    //    /**
    //     * Remove all sub views.
    //     * - version: 0.1.0
    //     * - date: 12/10/2016
    //     */
    //    public func removeAllSubviews() {
    //        for _ in 0 ..< subviews.count {
    //            removeView(atIndex: 0)
    //        }
    //    }
    //
    //    /**
    //     * Switch to next page.
    //     * - version: 0.1.0
    //     * - date: 12/10/2016
    //     */
    //    public func showNextPage() {
    //        switchToPage(pageControl.currentPage + 1)
    //    }
    //
    //    /**
    //     * Switch to previous page.
    //     * - version: 0.1.0
    //     * - date: 12/10/2016
    //     */
    //    public func showPreviousPage() {
    //        switchToPage(pageControl.currentPage - 1)
    //    }
    //
    //    /**
    //     * Switch to a specific news page.
    //     * - version: 0.1.0
    //     * - date: 12/10/2016
    //     * - parameter index: The page index of the news.
    //     * - parameter shouldAnimate: Whether the animation should be allowed or not.
    //     */
    //    public func switchToPage(index: Int, withAnimation shouldAnimate: Bool = true) {
    //        if ((index < 0) || (index >= subviews.count)) {
    //            logError(PageView.PageExistanceError)
    //            return
    //        }
    //        pageControl.currentPage = index
    //        if !shouldAnimate {
    //            self.contentOffset = CGPointMake(CGFloat(index) * self.frame.size.width, 0)
    //            return
    //        }
    //        // TODO: Judge whether there has been an animation operating or not.
    //        UIView.animate(withChange: { () -> Void in
    //            // COMMENT: Change the offset of the scroll view according to the page index.
    //            self.contentOffset = CGPointMake(CGFloat(index) * self.frame.size.width, 0)
    //        })
    //    }
    //
    //    /**
    //     * Initialize the object.
    //     * - version: 0.1.0
    //     * - date: 12/10/2016
    //     */
    //    private func initialize() {
    //        scrollEnabled = false
    //        backgroundColor = UIColor.clearColor()
    //        showsHorizontalScrollIndicator = false
    //        showsVerticalScrollIndicator = false
    //        pageControl.numberOfPages = subviews.count
    //        // COMMENT: Add gesture.
    //        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(PageView.showPreviousPage))
    //        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
    //        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(PageView.showNextPage))
    //        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
    //        addGestureRecognizer(swipeLeftGesture)
    //        addGestureRecognizer(swipeRightGesture)
    //    }
    //
    /**
     * UIView
     */
    public required init?(coder aDecoder: NSCoder) {
        pageControl = UIPageControl()
        super.init(coder: aDecoder)
        shouldShowPageControl = true
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        print("\(pageControlButtomMargin)")
        print("\(frame.height)")
    }
    
    /**
     * UIView
     */
//    public override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        pageControl.frame = CGRect(x: (rect.width - pageControl.frame.width) / 2, y: rect.height - pageControl.frame.height - pageControlButtomMargin, width: pageControl.frame.width, height: pageControl.frame.height)
//    }
    
    /**
     * UIView
     */
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = superview else {
            return
        }
        guard pageControl.superview == nil else {
            return
        }
        if pageControlButtomMargin == frame.height {
            pageControlButtomMargin = PageView.defaultPageControlButtomMargin
        }
        pageControl.frame = CGRect(x: (frame.width - pageControl.frame.width) / 2, y: frame.height - pageControl.frame.height - pageControlButtomMargin, width: pageControl.frame.width, height: pageControl.frame.height)
        superview.addSubview(pageControl)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
//        superview?.addSubview(pageControl)
//        pageControl.backgroundColor = UIColor.purple
    }
    
    /**
     * UIView
     */
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        pageControl.removeFromSuperview()
    }
    
}

import UIKit
