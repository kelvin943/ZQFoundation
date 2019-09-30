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
@synthesize indexPath     = _indexPath;

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init]; return [self yy_modelInitWithCoder:aDecoder];
}

//数组中的模型可以被深拷贝
- (id)copyWithZone:(NSZone *)zone{
    return [self yy_modelCopy];
}

- (NSUInteger)hash{
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object{
    return [self yy_modelIsEqual:object];
}

- (NSString *)description{
    return [self yy_modelDescription];
}

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
        _items = @[].mutableCopy;
    }
    return _items;
}

- (BOOL)hasNoMore {
    //当前个数小于总数，前提是每次接口返回的list需要追加到item中（由业务层实现）
    return ([self.items count] < self.totals);
}

@end
