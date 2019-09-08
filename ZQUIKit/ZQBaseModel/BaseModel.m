//
//  BaseModel.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseModel.h"

@implementation BaseModel

@synthesize cellClass     = _cellClass;
@synthesize cellType      = _cellType;
@synthesize cellHeight    = _cellHeight;
@synthesize cellTarget    = _cellTarget;

@end

@implementation BaseListModel

#pragma mark - synthesize
@synthesize items    = _items;
@synthesize page     = _page;
@synthesize rows     = _rows;
@synthesize hasMore  = _hasMore;
@synthesize totals   = _totals;


-(NSMutableArray *)items{
    if (!_items) {
        _items = @{}.mutableCopy;
    }
    return _items;
}
@end
