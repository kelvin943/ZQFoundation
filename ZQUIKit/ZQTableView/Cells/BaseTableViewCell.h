//
//  BaseTableViewCell.h
//  MJRefresh
//
//  Created by macro on 2019/9/7.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id<CellItemBasicProtocol> object;
+ (NSString *)cellIdentifier;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id<CellItemBasicProtocol>)object;

@end

