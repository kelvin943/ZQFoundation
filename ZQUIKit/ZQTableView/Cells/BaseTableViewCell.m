//
//  BaseTableViewCell.m
//  MJRefresh
//
//  Created by macro on 2019/9/7.
//

#import "BaseTableViewCell.h"

static const CGFloat DefaultEmptyCellHeight = 10.0f;
static const CGFloat DefaultCellHeight = 44.0f;

#define viewWidth  [UIScreen mainScreen].bounds.size.width

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0,viewWidth,0,0);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)setObject:(id<CellModelBasicProtocol>)cellModel {
    _cellModel = cellModel;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id<CellModelBasicProtocol>)cellModel {
    if (cellModel.cellHeight > 0) {
        return cellModel.cellHeight.floatValue;
    }
    return DefaultCellHeight;
}

@end

@implementation ZQEmptyCellItem
+ (instancetype)emptyCellItem {
    return [self emptyCellItemWithHeight:DefaultEmptyCellHeight];
}

+ (instancetype)emptyCellItemWithHeight:(CGFloat)height {
    return [self emptyCellItemWithHeight:height backgroundColor:[UIColor whiteColor]];
}

+ (instancetype)emptyCellItemWithBackgroundColor:(UIColor* )color {
    return [self emptyCellItemWithHeight:DefaultEmptyCellHeight backgroundColor:color];
}

+ (instancetype)emptyCellItemWithHeight:(CGFloat)height backgroundColor:(UIColor* )color {
    ZQEmptyCellItem *item = [ZQEmptyCellItem new];
    item.cellHeight = @(height);
    item.bgColor = color;
    item.cellClass = [ZQEmptyCell class];
    return item;
}
@end

@implementation ZQEmptyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellModel:(id<CellModelBasicProtocol>)object {
    [super setObject:object];
    if ([object isKindOfClass:[ZQEmptyCellItem class]]) {
        ZQEmptyCellItem *item = (ZQEmptyCellItem *)object;
        self.contentView.backgroundColor = item.bgColor;
    }
}
@end



@implementation ZQDefaultCellItem
+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr {
    return [self cellWithTitleStr:titleStr content:contentStr bgColor:[UIColor whiteColor] height:DefaultCellHeight];
}

+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr bgColor:(UIColor *)color {
    return [self cellWithTitleStr:titleStr content:contentStr bgColor:color height:DefaultCellHeight];
}
+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr height:(CGFloat)height {
    return [self cellWithTitleStr:titleStr content:contentStr bgColor:[UIColor whiteColor] height:height];
}
+ (instancetype)cellWithTitleStr:(NSString *)titleStr
                         content:(NSString*)contentStr
                         bgColor:(UIColor*)color
                           height:(CGFloat)height {
    ZQDefaultCellItem *item =  [ZQDefaultCellItem new];
    item.cellHeight = @(height);
    item.bgColor = color;
    item.titleStr = titleStr;
    item.contentStr = contentStr;
    item.cellClass = [ZQDefaultCell class];
    return item;
}

@end

@implementation ZQDefaultCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0,16,0,16);
    }
    return self;
}

- (void)setCellModel:(id<CellModelBasicProtocol>)object {
    [super setObject:object];
    if ([object isKindOfClass:[ZQDefaultCellItem class]]) {
        ZQDefaultCellItem *item = (ZQDefaultCellItem *)object;
        self.contentView.backgroundColor = item.bgColor;
        self.textLabel.text = item.titleStr;
        self.detailTextLabel.text = item.contentStr;
    }
}

@end
