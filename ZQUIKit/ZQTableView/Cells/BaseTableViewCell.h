//
//  BaseTableViewCell.h
//  MJRefresh
//
//  Created by macro on 2019/9/7.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong) id<CellModelBasicProtocol> cellModel;
+ (NSString *)cellIdentifier;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id<CellModelBasicProtocol>)cellModel;

@end

//cell快速创建
#pragma mark - empty cell
@interface ZQEmptyCellItem : BaseModel
@property (nonatomic,strong) UIColor *bgColor;
+ (instancetype)emptyCellItem;
+ (instancetype)emptyCellItemWithHeight:(CGFloat)height;
+ (instancetype)emptyCellItemWithBackgroundColor:(UIColor*)color;
+ (instancetype)emptyCellItemWithHeight:(CGFloat)height backgroundColor:(UIColor*)color;

@end

@interface ZQEmptyCell: BaseTableViewCell
@end


#pragma mark - system default cell
@interface ZQDefaultCellItem : BaseModel
@property (nonatomic,  copy) NSString *titleStr;
@property (nonatomic,  copy) NSString *contentStr;
@property (nonatomic,strong) UIColor  *bgColor;
@property (nonatomic,assign) UIEdgeInsets separatorInset;
+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr;
+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr bgColor:(UIColor*)color;
+ (instancetype)cellWithTitleStr:(NSString *)titleStr content:(NSString*)contentStr height:(CGFloat)height;
+ (instancetype)cellWithTitleStr:(NSString *)titleStr
                         content:(NSString*)contentStr
                         bgColor:(UIColor*)color
                          height:(CGFloat)height;
@end
@interface ZQDefaultCell : BaseTableViewCell
@end


#pragma mark - custom default cell
@interface ZQCustomDefaultCellItem : BaseModel
@property (nonatomic,  copy) NSString *titleStr;
@property (nonatomic,  copy) NSString *subTitleStr;
@property (nonatomic,  copy) NSString *flagImageIconStr;
@property (nonatomic,strong) UIColor  *bgColor;
@property (nonatomic,assign) UIEdgeInsets separatorInset;

+ (instancetype)cellWithTitleStr:(NSString *)titleStr subTitle:(NSString*)subTitleStr;

@end

@interface ZQCustomDefaultCell : BaseTableViewCell

@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;
@property (nonatomic,strong) UIImageView *flagImageView;

@end


