//
//  BaseTableViewAdaptor.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellItemBasicProtocol;
@protocol BaseTableViewAdaptorDelegate <NSObject>

@optional
//选中 cell 后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withRowObject:(id<CellItemBasicProtocol>)object;

//对cell设置数据源之后调用
- (void)tableView:(UITableView *)tableView didSetObject:(id<CellItemBasicProtocol>)object cell:(UITableViewCell *)cell;

@end


@interface BaseTableViewAdaptor : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,   weak) id<BaseTableViewAdaptorDelegate> delegate;
@property (nonatomic,   weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL dragRefreshEnable;

@end

NS_ASSUME_NONNULL_END
