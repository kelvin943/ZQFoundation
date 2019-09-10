//
//  BaseTableViewAdaptor.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZQTableViewRefreshType){
    ZQTableViewRefreshTypePullDown = 1,       //下拉
    ZQTableViewRefreshTypePullUp ,            //上拉
};



NS_ASSUME_NONNULL_BEGIN

@protocol CellItemBasicProtocol;
@protocol BaseTableViewAdaptorDelegate <UITableViewDelegate>

@optional
//选中 cell 后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withRowObject:(id<CellItemBasicProtocol>)object;

//对cell设置数据源之后调用
- (void)tableView:(UITableView *)tableView didSetObject:(id<CellItemBasicProtocol>)object cell:(UITableViewCell *)cell;

// 下拉刷新回调
- (void)refreshReload:(ZQTableViewRefreshType)pullType;
@end


@interface BaseTableViewAdaptor : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,   weak) id<BaseTableViewAdaptorDelegate> delegate;
@property (nonatomic,   weak) UITableView *tableView;
//数据源
@property (nonatomic, strong) NSMutableArray *items;
//是否开启下拉刷新
@property (nonatomic, assign) BOOL pullRefreshEnable;
//是否开启上拉加载
@property (nonatomic, assign) BOOL loadMoreEnable;

@end

NS_ASSUME_NONNULL_END
