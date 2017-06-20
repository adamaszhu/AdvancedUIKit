#import <UIKit/UIKit.h>

/**
 * ExpandableListCell is used to maintain a cell that can be extended.
 * - author: Adamas
 * - version: 0.0.4
 * - date: 24/10/2016
 */
@interface ExpandableListCell : UITableViewCell

/**
 * The icon used to show whether current cell is expanded or not.
 */
@property (weak, nonatomic, nullable) IBOutlet UIImageView *statusIconImage;

/**
 * The expand title.
 */
@property (weak, nonatomic, nullable) IBOutlet UIView *titleView;

/**
 * The expand detail.
 */
@property (weak, nonatomic, nullable) IBOutlet UIView *detailView;

/**
 * The item that the cell is displaying.
 */
@property (nullable) id item;

/**
 * The height after the cell is extended.
 */
@property (nonatomic, readonly) CGFloat expandedHeight;

/**
 * The height when the cell is folded.
 */
@property (nonatomic, readonly) CGFloat foldedHeight;

- (void)renderWithItem;

@end
