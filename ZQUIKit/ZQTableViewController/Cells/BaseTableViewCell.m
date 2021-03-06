//
//  BaseTableViewCell.m
//  MJRefresh
//
//  Created by macro on 2019/9/7.
//

#import "BaseTableViewCell.h"
#import "UIView+ZQExten.h"
#import "UIImage+ZQAdd.h"
#import "UIColor+ZQAdd.h"

static const CGFloat DefaultEmptyCellHeight = 10.0f;
static const CGFloat DefaultCellHeight = 44.0f;

#define viewWidth  [UIScreen mainScreen].bounds.size.width

@implementation BaseTableViewCell

//xib 初始化
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //保证从xib 初始化后其他的设置和手动初始化设置一样
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0,0,0,viewWidth);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
//手动初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置 right 而不设置 left 的原因是设置 left 会影响系统默认cell (ZQDefaultCell) 的右侧布局
        //这里猜测 系统cell 的detailTextLabel布局与此属性有关
        self.separatorInset = UIEdgeInsetsMake(0,0,0,viewWidth);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)setCellModel:(id<CellModelBasicProtocol>)cellModel {
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
    [super setCellModel:object];
    if ([object isKindOfClass:[ZQEmptyCellItem class]]) {
        ZQEmptyCellItem *item = (ZQEmptyCellItem *)object;
        self.contentView.backgroundColor = item.bgColor;
        self.backgroundColor             = item.bgColor;
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
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellModel:(id<CellModelBasicProtocol>)object {
    [super setCellModel:object];
    if ([object isKindOfClass:[ZQDefaultCellItem class]]) {
        ZQDefaultCellItem *item = (ZQDefaultCellItem *)object;
        self.contentView.backgroundColor = item.bgColor;
        self.backgroundColor             = item.bgColor;
        self.textLabel.text              = item.titleStr;
        self.detailTextLabel.text = item.contentStr;
        if (item.separatorInset.left >0 || item.separatorInset.right > 0) {
            //如果设置过分割线的间距就显示，默认由父视图设置的 UIEdgeInsetsMake(0,viewWidth,0,0) 不展示.git
            self.separatorInset              = item.separatorInset;
        }
    }
}

@end


@implementation ZQCustomDefaultCellItem

+ (instancetype)cellWithTitleStr:(NSString *)titleStr subTitle:(NSString*)subTitleStr {
    ZQCustomDefaultCellItem *item =  [ZQCustomDefaultCellItem new];
    item.cellHeight     = @(55);
    item.titleStr       = titleStr;
    item.subTitleStr    = subTitleStr;
    item.bgColor        = [UIColor whiteColor];
    item.cellClass      = [ZQCustomDefaultCell class];
    return item;
}
@end
@implementation ZQCustomDefaultCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupContentView];
    }
    return self;
}
- (void)setupContentView {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.flagImageView];
}

- (void)layoutSubviews {
    //不调用父视图的重新布局会导致 cell 系统自己的分割线不显示
    [super layoutSubviews];
    CGFloat margin = 16;
    self.titleLabel.left = margin;
    self.titleLabel.top     = 18;
    self.titleLabel.width   = 100;
    self.titleLabel.height  = 20;

    self.flagImageView.top     = 18;
    self.flagImageView.left    = self.width - margin - 20;
    self.flagImageView.width   = 20;
    self.flagImageView.height  = 20;

    self.subTitleLabel.top     = 18;
    self.subTitleLabel.left   = self.flagImageView.left -108;
    self.subTitleLabel.width   = 100;
    self.subTitleLabel.height  = 20;
}

- (void)setCellModel:(id<CellModelBasicProtocol>)object {
    [super setCellModel:object];
    if ([object isKindOfClass:[ZQCustomDefaultCellItem class]]) {
        ZQCustomDefaultCellItem *item = (ZQCustomDefaultCellItem *)object;
        self.contentView.backgroundColor = item.bgColor;
        self.backgroundColor             = item.bgColor;
        self.titleLabel.text             = item.titleStr;
        self.subTitleLabel.text          = item.subTitleStr;
        if (item.separatorInset.left >0 || item.separatorInset.right > 0) {
            //如果设置过分割线的间距就显示，默认由父视图设置的 UIEdgeInsetsMake(0,viewWidth,0,0) 不展示
            self.separatorInset              = item.separatorInset;
        }
        self.flagImageView.image = item.flagImageIconStr.length > 0 ? [UIImage imageFromIconfontWithIconStr:item.flagImageIconStr size:20 color:[UIColor colorWithHex:0x999999]] : [UIImage imageNamed:@"right_arrow"];

    }
}


#pragma mark - lazy load
- (UILabel*)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithHex:0x333333];
    }
    return _titleLabel;
}

- (UILabel*)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.textColor = [UIColor colorWithHex:0x333333];
    }
    return _subTitleLabel;
}
- (UIImageView*)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc] init];
    }
    return _flagImageView;
}

@end
