#import "ExpandableListCell.h"

@interface ExpandableListCell()

/**
 * The folded height value.
 */
@property CGFloat foldedHeightValue;

/**
 * The expanded height value.
 */
@property CGFloat expandedHeightValue;

@end

@implementation ExpandableListCell

/**
 * Get expandedHeight.
 * - version: 0.0.4
 * - date: 24/10/2016
 */
- (CGFloat)expandedHeight {
    if(_titleView == nil) {
        _titleView = self.contentView;
    }
    CGFloat detailHeight = _detailView == nil ? 0 : _detailView.frame.size.height;
    return detailHeight + _titleView.frame.size.height;
}

/**
 * Get foldedHeight.
 * - version: 0.0.4
 * - date: 24/10/2016
 */
- (CGFloat)foldedHeight {
    if(_titleView == nil) {
        _titleView = self.contentView;
    }
    return _titleView.frame.size.height;
}

/**
 * Render the cell according to the item. This function should be overrided.
 * - version: 0.0.4
 * - date: 24/10/2016
 */
- (void)renderWithItem {
    
}

/**
 * - version: 0.0.4
 * - date: 24/10/2016
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.clipsToBounds = true;
    return self;
}

@end
