//
//  BaseTableViewCell.m
//  MJRefresh
//
//  Created by macro on 2019/9/7.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)setObject:(id<CellItemBasicProtocol>)object {
    _object = object;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<CellItemBasicProtocol>)object {
    if (object.cellHeight > 0) {
        return object.cellHeight.floatValue;
    }
    return 44.0;
}

@end
